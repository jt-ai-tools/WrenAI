這是一個使用 [`create-next-app`](https://github.com/vercel/next.js/tree/canary/packages/create-next-app) 啟動的 [Next.js](https://nextjs.org/) 專案。

## 從源代碼啟動 wren-ui

步驟 1. 確保您的 Node 版本為 18
```bash
node -v
```

步驟 2. 安裝依賴項目：

```bash
yarn 
```

步驟 3 (選用). 切換資料庫

Wren-ui 預設使用 SQLite 作為資料庫。若要使用 Postgres，您需要設置以下兩個環境變數。

```bash
# Windows
SET DB_TYPE=pg
SET PG_URL=postgres://user:password@localhost:5432/dbname 

# Linux 或 Mac
export DB_TYPE=pg
export PG_URL=postgres://user:password@localhost:5432/dbname
```
- `PG_URL` 是您的 Postgres 資料庫連接字串。

若要切換回 SQLite，可以將 `DB_TYPE` 重新設定為 `sqlite`。
```bash
# Windows
SET DB_TYPE=sqlite
SET SQLITE_FILE={您的_sqlite_檔案路徑} # 預設為 ./db.sqlite3

# Linux 或 Mac
export DB_TYPE=sqlite
export SQLITE_FILE={您的_sqlite_檔案路徑}
```

步驟 4. 執行資料庫遷移 (Migration)：

```bash
yarn migrate
# 或者
npm run migrate
```


步驟 5. 啟動開發伺服器：

```bash
# 如果您是透過 Docker 啟動 wren-engine 和 ibis-server，請執行以下指令
# Linux 或 MacOS
export OTHER_SERVICE_USING_DOCKER=true
export EXPERIMENTAL_ENGINE_RUST_VERSION=false # 若要使用實驗性的 Rust 版本 Wren Engine，請設為 true
# Windows
SET OTHER_SERVICE_USING_DOCKER=true
SET EXPERIMENTAL_ENGINE_RUST_VERSION=false # 若要使用實驗性的 Rust 版本 Wren Engine，請設為 true

# 啟動開發伺服器
yarn dev
# 或者
npm run dev
```

在瀏覽器中開啟 [http://localhost:3000](http://localhost:3000) 即可查看結果。


## 在本地開發 wren-ui 模組
Wren AI 包含多個模組。若要開發 wren-ui，您可以透過 docker-compose 啟動其他模組（服務）。
在 [從源代碼啟動 wren-ui](#從源代碼啟動-wren-ui) 章節中，您已經了解如何從源代碼啟動 wren-ui 進行開發。
若要透過 docker-compose 啟動其他模組，請遵循以下步驟。

步驟 1. 準備您的 .env 檔案
在 `WrenAI/docker` 資料夾中可以找到 `.env.example` 檔案。您可以將此檔案複製為 `.env.local`。

```bash
# 假設當前目錄是 wren-ui
cd ../docker
cp .env.example .env.local
```
步驟 2. 修改您的 .env.local 檔案
啟動前，您需要在 `OPENAI_API_KEY` 中填入您的 OpenAI API 金鑰。

您也可以將 `WREN_ENGINE_VERSION`、`WREN_AI_SERVICE_VERSION`、`IBIS_SERVER_VERSION` 更改為您想使用的版本。


步驟 3. 透過 docker-compose 啟動服務
```bash
# 當前目錄為 WrenAI/docker
docker-compose -f docker-compose-dev.yaml --env-file .env.example up

# 您可以加上 -d 參數讓服務在背景執行
docker-compose -f docker-compose-dev.yaml --env-file .env.example up -d
# 停止服務請使用：
docker-compose -f docker-compose-dev.yaml --env-file .env.example down
```

步驟 4. 從源代碼啟動 wren-ui
請參考 [從源代碼啟動 wren-ui](#從源代碼啟動-wren-ui) 章節。

步驟 5. (選用) 同時開發其他模組

如上所述，您可以使用 docker-compose 啟動其他模組。在開發其他模組時也是如此。
從 wren-ui 的角度來看，如果您想同時開發其他模組，可以停止該容器，然後從源代碼啟動該模組。

例如：如果您想開發 `ai-service` 模組，可以停止 `ai-service` 容器，然後從源代碼啟動 `ai-service`。
```yaml
# docker/docker-compose-dev.yaml
wren-engine:
    image: ghcr.io/canner/wren-engine:${WREN_ENGINE_VERSION}
    ...
# 註釋掉 ai-service 服務
wren-ai-service:
    image: ghcr.io/canner/wren-ai-service:${WREN_AI_SERVICE_VERSION}
    ...
```
接著參考該模組的 README.md 或 CONTRIBUTION.md 檔案以從源代碼啟動。

例如：參考 [ai-service README](./../wren-ai-service/README_zh_TW.md#為開發環境啟動服務) 以從源代碼啟動 ai-service。



## 常見問題 (FAQ)
### Wren AI 支援同時擁有多個專案嗎？
目前 Wren AI 不支援多個專案，一次只能有一個專案。
但有一個替代方案：由於 Wren Engine 是無狀態的，且我們將您的語義模型存儲在資料庫中（Sqlite 或 Postgres），您可以通過切換資料庫並在伺服器啟動後進行部署來在專案之間切換。

> 提示：定義 `DB_TYPE` 和 `SQLITE_FILE` 或 `PG_URL` 變數來指定您打算使用的資料庫。

範例：
```bash
# 使用預設資料庫啟動第一個專案 (預設為 sqlite)
yarn migrate
yarn dev

# ... 經過引導與努力後，您想切換到另一個專案
# 停止伺服器

# 設置另一個 sqlite 檔案
export SQLITE_FILE=./new_project.sqlite
yarn migrate
yarn dev

# 在瀏覽器中 ... 經過另一次引導與努力後
# 您可以透過設置第一個 sqlite 檔案來切換回第一個專案
export SQLITE_FILE=./first_project.sqlite

yarn dev  # 不需要再次執行遷移 (migration)

# 在建模 (modeling) 頁面，點擊部署 (deploy) 按鈕將專案部署到 wren-ai-service。
# 您的 Wren AI 已準備好回答問題。
```

## 深入學習

要深入了解 Next.js，請參考以下資源：

- [Next.js 文件](https://nextjs.org/docs) - 了解 Next.js 功能與 API。
- [學習 Next.js](https://nextjs.org/learn) - 互動式的 Next.js 教學。

您可以造訪 [Next.js GitHub 儲存庫](https://github.com/vercel/next.js/) - 歡迎提供意見與貢獻！
