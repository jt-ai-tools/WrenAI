# Wren AI 的 AI 服務 (AI Service)

## 概念

請閱讀此處的[文件](https://docs.getwren.ai/oss/concept/wren_ai_service)以了解 Wren AI 服務的核心概念。

## 本地開發設置

### 先決條件

1. **Python**: 安裝 Python 3.12.\*
   - 建議：使用 [`pyenv`](https://github.com/pyenv/pyenv?tab=readme-ov-file#installation) 來管理 Python 版本。

2. **Poetry**: 安裝 Poetry 1.8.3
   ```bash
   curl -sSL https://install.python-poetry.org | python3 - --version 1.8.3
   ```

3. **Just**: 安裝 [Just](https://github.com/casey/just?tab=readme-ov-file#packages) 指令執行器 (1.36 或更高版本)。

### 逐步設置說明

1. **安裝依賴項目**:
   ```bash
   poetry install
   ```

2. **生成配置文件**:
   ```bash
   just init
   ```
   這將建立 `.env.dev` 和 `config.yaml`。使用 `just init --non-dev` 可僅生成 `config.yaml`。

    > 對於 Windows 使用者，請在 Justfile 的開頭添加 `set shell:= ["bash", "-cu"]`。

4. **配置環境**:
   - 編輯 `.env.dev` 以設置環境變數。
   - 修改 `config.yaml` 以配置組件、pipelines 及其他設定。
   - 參考 [AI 服務配置說明](./docs/configuration_zh_TW.md) 以獲取詳細的設置指南。

5. **設置開發環境** (選用):
   - 安裝 pre-commit hooks:
     ```bash
     poetry run pre-commit install
     ```
   - 執行初始的 pre-commit 檢查:
     ```bash
     poetry run pre-commit run --all-files
     ```

6. **執行測試** (選用):
   ```bash
   just test
   ```

### 啟動服務

1. **啟動必要的容器**:
   ```bash
   just up
   ```

2. **啟動 AI 服務**:
   ```bash
   just start
   ```

3. **訪問服務**:
   - API 文件：`http://WREN_AI_SERVICE_HOST:WREN_AI_SERVICE_PORT` (預設為 <http://localhost:5556>)
   - 使用者介面：`http://WREN_UI_HOST:WREN_UI_PORT` (預設為 <http://localhost:3000>)

4. **停止服務**:
   完成後，停止容器：
   ```bash
   just down
   ```

此設置可確保開發環境的一致性，並透過 pre-commit hooks 和測試來維護代碼質量。請遵循上述步驟開始 Wren AI 服務的本地開發。

## 其他項目

### Pipeline 評估 (Evaluation)

要全面了解如何評估 pipelines，請參考 [評估框架說明](./eval/README_zh_TW.md)。該文件提供了評估過程的詳細指南，包括如何設置與執行評估、解讀結果以及如何有效利用評估指標。這對於確保評估準確執行且結果具備意義是非常有價值的資源。

### 估計 Pipeline 速度 (可能已過時)

- 執行負載測試 (Load Test)：
  - 在 `.env.dev` 中設置 `DATASET_NAME`。
  - 根據需要調整測試配置。
    - 在 `tests/locust/config_users.json` 中調整使用者數量。
  - 在 `wren-ai-service` 資料夾中執行 `just up` 以啟動 Docker 容器。
  - 在 `wren-ai-service` 資料夾中執行 `just start` 以啟動 AI 服務。
  - 執行 `just load-test`。
  - 查看 `/outputs/locust` 資料夾中的報告，會有 3 個檔名為 **locust_report_{測試時間戳記}** 的檔案：
    - .json：JSON 格式的測試報告，包含 LLM 提供者、版本等資訊。
    - .html：HTML 格式的測試報告，顯示圖表與表格。
    - .log：測試日誌。

## 貢獻

感謝您投入時間為我們的專案做出貢獻！請[閱讀此處以獲取更多資訊](./CONTRIBUTING_zh_TW.md)！
