# CLAUDE.md

此檔案為 Claude Code (claude.ai/code) 在此儲存庫中工作時提供指導。

## 專案概覽

WrenAI 是一個開源的 GenBI (Generative BI) 代理 (Agent)，可將自然語言問題轉換為 SQL 查詢與圖表。它使用語義層 (MDL - Metadata Definition Language)，透過檢索增強生成 (RAG) 來引導 LLM 驅動的 text-to-SQL 生成。

## 儲存庫結構

這是一個包含三個主要服務的 Monorepo：

- **wren-ui/** — Next.js 14 前端 + Apollo GraphQL 後端 (TypeScript, Yarn 4.5.3)
- **wren-ai-service/** — AI/LLM 服務 (Python 3.12, FastAPI, Poetry, Just 指令執行器)
- **wren-launcher/** — CLI 部署工具 (Go 1.18+, Make)
- **docker/** — 用於同時執行所有服務的 Docker Compose 配置
- **deployment/** — Kubernetes/Kustomize 清單 (Manifests)
- **wren-engine/** — SQL 引擎 (git submodule，不在本處開發)
- **wren-mdl/** — MDL JSON schema 定義

## 建置、測試與 Lint 指令

### wren-ui (TypeScript/Next.js)

```bash
cd wren-ui
yarn install
yarn dev                # 啟動於 3000 埠的開發伺服器 (TZ=UTC)
yarn build              # 正式環境建置 (max-old-space-size=8192)
yarn lint               # TypeScript 類型檢查 + ESLint
yarn check-types        # tsc --noEmit
yarn test               # Jest 單元測試
yarn test:e2e           # Playwright E2E 測試 (會安裝 chromium)
yarn migrate            # Knex 資料庫遷移 (Migration)
yarn rollback           # Knex 資料庫遷移回退 (Rollback)
yarn generate-gql       # 從 codegen.yaml 進行 GraphQL 代碼生成 (Codegen)
```

環境設定：設置 `DB_TYPE=sqlite` (預設) 或 `DB_TYPE=pg` 以及 PostgreSQL 連接變數。UI 需要 `WREN_ENGINE_ENDPOINT`、`WREN_AI_ENDPOINT` 和 `IBIS_SERVER_ENDPOINT` 來連接後端服務。

### wren-ai-service (Python/FastAPI)

```bash
cd wren-ai-service
poetry install
just init               # 從範例建立 config.yaml 和 .env.dev
just up                 # 啟動開發用的 Docker 服務 (Qdrant, engine 等)
just start              # 執行 AI 服務 (poetry run python -m src.__main__)
just test               # pytest (會啟動 Docker 依賴，忽略 usecases)
just test [test_args]   # 例如：just test tests/pytest/pipelines/
just test-usecases      # 執行 use-case 整合測試
just down               # 停止 Docker 服務
just load-test          # Locust 壓力測試
```

配置透過 `config.yaml` 進行（多文檔 YAML，包含 LLM、embedder、engine、document_store、pipeline 及 settings 區段）。環境變數設置於 `.env.dev` (API keys)。設定加載順序：預設值 → 環境變數 → .env.dev → config.yaml。

Pre-commit hooks：先執行 `poetry run pre-commit install`，然後執行 `poetry run pre-commit run --all-files`。

### wren-launcher (Go)

```bash
cd wren-launcher
make build              # 為 macOS/Linux/Windows 進行交叉編譯
make test               # go test ./...
make check              # fmt + vet + lint (golangci-lint)
make lint-fix           # 自動修復 lint 問題
```

## 系統架構

### 服務間通信流程

```
使用者 → Wren UI (Next.js :3000)
         ↓ GraphQL (內嵌於 Next.js API 路由的 Apollo Server)
       Apollo Server → Wren AI 服務 (FastAPI :5556) [HTTP REST]
                     → Wren Engine (:8080) [SQL 驗證/執行]
                     → Ibis Server (:8000) [用於數據源的 SQL 抽象層]
       Wren AI 服務 → Qdrant (:6333) [用於 RAG 的向量搜尋]
                       → LLM 提供者 (OpenAI/Azure 等) [text-to-SQL 生成]
```

### Wren UI 內部架構

Next.js 應用程式在其 API 路由 (`src/apollo/`) 中嵌入了 Apollo GraphQL 伺服器：

- **`src/apollo/server/resolvers/`** — GraphQL 解析器 (asking, model, project, dashboard 等)
- **`src/apollo/server/services/`** — 業務邏輯層 (askingService, deployService, mdlService, queryService 等)
- **`src/apollo/server/repositories/`** — 使用 Knex 的數據存取層 (SQLite 或 PostgreSQL)
- **`src/apollo/server/adaptors/`** — 外部服務適配器 (AI service, engine)
- **`src/apollo/client/`** — 前端 GraphQL 操作
- **`src/components/`** — 按頁面組織的 React 組件 (home, setup, modeling, knowledge)
- **`src/pages/`** — Next.js 頁面路由

路徑別名：`@/*` → `./src/*`, `@server/*` → `./src/apollo/server/*`

### Wren AI 服務內部架構

Python 服務使用基於 Pipeline 的架構：

- **`src/pipelines/`** — RAG pipeline 實作：
  - `indexing/` — MDL schema、資料表描述、歷史問題、SQL 配對 → Qdrant
  - `retrieval/` — 從 Qdrant 進行相關背景資訊的語義搜尋
  - `generation/` — SQL 生成、圖表生成、意圖分類
  - `ask/` — 編排檢索 + 生成以進行 text-to-SQL
  - `ask_details/` — SQL 拆解與解釋
  - `semantics/` — 語義處理輔助工具
- **`src/web/v1/services/`** — 服務層 (AskService, SemanticsPreparationService, ChartService, SqlPairsService 等)
- **`src/web/v1/routers/`** — FastAPI 路由處理器
- **`src/core/`** — 基礎抽象 (pipeline, provider, engine 介面)
- **`src/globals.py`** — 將所有服務與 pipeline 串接在一起的 ServiceContainer
- **`src/config.py`** — 包含所有配置參數的 Pydantic Settings

Pipelines 在 `config.yaml` 中以聲明方式配置，將 LLM 提供者、embedders、document stores 和 engines 串接到命名的 pipeline 組件。

### "Ask" (Text-to-SQL) 資料流

1. 使用者在 UI 提交自然語言問題
2. UI 發送 GraphQL mutation 給 Apollo Server
3. Apollo Server 呼叫 AI 服務的 REST API
4. AI 服務執行意圖分類 → 從 Qdrant 檢索相關 schema/背景資訊 → 透過 LLM 生成 SQL
5. 生成的 SQL 會針對 Wren Engine 進行驗證
6. 如果驗證失敗，會嘗試進行 SQL 修正（最多 `max_sql_correction_retries` 次）
7. 結果依序返回至 UI

### MDL (Metadata Definition Language)

將業務概念映射到資料庫 schema 的語義層。定義了模型 (models)、欄位 (columns)、關聯 (relationships)、指標 (metrics) 和計算欄位。MDL 被索引至 Qdrant 作為向量嵌入 (embeddings)，為 LLM 的 SQL 生成提供背景資訊。Schema 定義於 `wren-mdl/mdl.schema.json`。

## Docker 開發

要在本地執行完整堆疊：
```bash
cd docker
cp .env.example .env.local    # 配置 API keys 和埠號
cp config.example.yaml config.yaml
docker compose --env-file .env.local up -d
```

若要在其他服務於 Docker 執行時開發單一服務，請使用 AI 服務 `tools/dev/` 目錄中的 `docker-compose-dev.yaml`。

## 提交規範 (Commit Convention)

遵循 Conventional Commits：`type(scope): description`
- Scopes: `wren-ui`, `wren-ai-service`, `wren-launcher`
- Types: `feat`, `fix`, `chore`, `refactor`
- 範例: `feat(wren-ui): add dashboard widget`, `fix(wren-ai-service): handle empty MDL`

## CI/CD

- PR 標籤會觸發特定服務的 CI：`ci/ui` 觸發 UI 測試/lint，`ci/ai-service` 觸發 AI 服務測試
- Docker 鏡像發布至 `ghcr.io/canner/`
