# 貢獻指南 (Contributing Guidelines)

*我們非常歡迎並鼓勵任何形式的貢獻，包括 Pull Request、Bug 回報以及其他各種建議！* :octocat:

### 目錄

- [行為準則](#book-行為準則)
- [概覽](#mag-概覽)
- [不同服務的貢獻指南](#love_letter-不同服務的貢獻指南)
- [建立新的數據源連接器](#electric_plug-建立新的數據源連接器)

> **本指南旨在為所有參與專案的成員設定明確的預期，以便我們能共同改進專案，同時為每位參與者營造一個友好的空間。遵循這些準則將有助於確保貢獻者與維護者都能獲得積極的體驗。**

## :book: 行為準則 (Code of Conduct)

請參閱我們的 [行為準則](./CODE_OF_CONDUCT_zh_TW.md)。該準則隨時有效，我們期望每位貢獻者都能遵守。我們不容忍任何冒犯他人的行為。


## :rocket: 開始行動
1. 造訪 [Wren AI 的運作原理](https://docs.getwren.ai/oss/overview/how_wrenai_works) 以了解 Wren AI 的系統架構。
2. 了解架構後，請確認您想要貢獻的服務範圍。
   請查看 [不同服務的貢獻指南](#love_letter-不同服務的貢獻指南) 中的各服務章節，學習如何進行貢獻。
    1. 如果您處理的是 UI 相關任務（例如添加深色模式），您只需要貢獻至 [Wren UI 服務](#wren-ui-服務)。
    2. 如果您處理的是 LLM 相關任務（例如增強 LLM pipeline 中使用的提示詞），您只需要貢獻至 [Wren AI 服務](#wren-ai-服務)。
    3. 如果您處理的是數據源相關任務（例如修復 SQL Server 連接器的 Bug），您需要貢獻至 [Wren Engine 服務](#wren-engine-服務)。
3. 如果您不確定應該貢獻到哪個服務，請透過 [Discord](https://discord.gg/canner) 或 [GitHub Issues](https://github.com/Canner/WrenAI/issues) 與我們聯繫。
4. 您可能需要同時貢獻至多個服務。例如，添加新數據源時，您需要貢獻至 [Wren UI 服務](#wren-ui-服務) 和 [Wren Engine 服務](#wren-engine-服務)。請參考 [多服務貢獻指南](#多服務貢獻指南) 以了解如何同時對多個服務進行貢獻。

## :love_letter: 不同服務的貢獻指南

### Wren AI 服務

Wren AI 服務負責處理 LLM 相關任務，例如將自然語言問題轉換為 SQL 查詢，並提供逐步的 SQL 解析。

要貢獻至 Wren AI 服務，請參考 [Wren AI 服務貢獻指南](./wren-ai-service/CONTRIBUTING_zh_TW.md)。


### Wren UI 服務

Wren UI 是 WrenAI 的用戶端服務，使用 Next.js 和 TypeScript 構建。
要貢獻至 Wren UI，您可以參考 [wren-ui/README_zh_TW.md](./wren-ui/README_zh_TW.md) 檔案，了解如何設置開發環境並啟動開發伺服器。


### Wren Engine 服務
Wren Engine 是 Wren AI 專案的核心，它是 LLM 的語義引擎，為 AI 代理提供商業背景資訊。

要貢獻此服務，請參考 [Wren Engine 貢獻指南](https://github.com/Canner/wren-engine/blob/main/ibis-server/docs/CONTRIBUTING.md) (目前僅有英文版)。

## 多服務貢獻指南
我們依賴 docker-compose 來啟動所有服務。如果您要貢獻至多個服務，可以從源代碼中註釋掉您想要啟動的服務，並更改 `env` 變數以指向您自行啟動的服務。

### 範例：同時貢獻至 [Wren UI 服務](#wren-ui-服務) 和 [Wren Engine 服務](#wren-engine-服務)
如果您同時對 [Wren UI 服務](#wren-ui-服務) 和 [Wren Engine 服務](#wren-engine-服務) 進行貢獻，應在 `docker/docker-compose-dev.yml` 檔案中註釋掉 `wren-engine` 服務（請注意，UI 服務已預設從該檔案中排除）。接著，調整 `.env` 檔案中的環境變數，使其指向您手動啟動的服務。這將確保您的本地開發環境能正確與正在開發中的服務進行對接。

1. 準備您的 `.env` 檔案：在 `WrenAI/docker` 資料夾中，使用 `.env.example` 作為模板。複製該檔案並建立 `.env.local`。
    ```sh
    # 假設當前目錄是 wren-ui
    cd ../docker
    cp .env.example .env.local
    ```
2. 修改 `.env.local` 檔案：在啟動前填入您的 `OPENAI_API_KEY`。
3. 在 `WrenAI/docker` 資料夾中，將 `config.example.yaml` 複製為 `config.yaml` 以供 AI 服務配置使用。同時將 `config.yaml` 中的 `http://wren-ui:3000` 更改為 `http://host.docker.internal:3000`。
4. 從源代碼啟動 UI 和 Engine 服務。
5. 更新 `.env.local` 檔案中的 `env` 變數，指向您手動啟動的服務。
6. 使用 docker-compose 啟動其他服務：
    ```sh
    # 當前目錄為 WrenAI/docker
    docker-compose -f docker-compose-dev.yaml --env-file .env.example up

    # 您可以加入 -d 參數讓服務在背景執行
    docker-compose -f docker-compose-dev.yaml --env-file .env.example up -d
    # 若要停止服務，請使用
    docker-compose -f docker-compose-dev.yaml --env-file .env.example down
    ```
7. 祝您開發愉快！

## :electric_plug: 建立新的數據源連接器

要開發新的數據源連接器，除了 Wren Engine 之外，您還需要修改 Wren UI 的前端與後端。

以下是數據源連接器的簡要概覽：

<img src="./misc/data_source.png" width="400">

UI 主要負責儲存資料庫連接設定，提供使用者輸入這些設定的介面，並將其提交給 Engine，最後由 Engine 連接到資料庫。

UI 必須知道 Engine 所需保留的連接詳細資訊。因此，實作順序如下：


- Engine:
  - 實作新數據源（您將確定需要哪些連接資訊，以及如何從 UI 傳遞）。
  - 實作供 UI 存取的 Metadata API。
- UI:
  - 後端 (Back-End):
    - 安全地儲存連接資訊。
    - 將連接資訊提供給 Engine。
  - 前端 (Front-End):
    - 準備數據源的圖示 (Icon)。
    - 設置供使用者輸入連接資訊的表單模板。
    - 更新數據源列表。

### Wren Engine

- 要實作新的數據源，請參考 [如何添加新數據源](https://github.com/Canner/wren-engine/blob/main/ibis-server/docs/how-to-add-data-source.md)。
- 添加新數據源後，您可以開始為 UI 實作 Metadata API。

  以下是先前引入新數據源的 PR 範例：
    - [添加 MSSQL 數據源](https://github.com/Canner/wren-engine/pull/631)
    - [添加 MySQL 數據源](https://github.com/Canner/wren-engine/pull/618)
    - [添加 ClickHouse 數據源](https://github.com/Canner/wren-engine/pull/648)

### Wren UI 指南

我們將說明在 UI 中為每個新數據源應完成的工作。

如果您喜歡透過範例學習，可以參考這個 Trino 的 [Issue](https://github.com/Canner/WrenAI/issues/492) 和 [PR](https://github.com/Canner/WrenAI/pull/535)。


#### 後端 (Backend)
1. 在 `wren-ui/src/apollo/server/dataSource.ts` 中定義數據源
  - 定義 `toIbisConnectionInfo` 和 `sensitiveProps` 方法

2. 修改 `wren-ui/src/apollo/server/adaptors/ibisAdaptor.ts` 中的 ibis 適配器
  - 為新數據源定義 ibis 連接資訊類型
  - 設置新數據源的 `dataSourceUrlMap`

3. 修改 `wren-ui/src/apollo/server/repositories/projectRepository.ts` 中的 Repository
  - 為新數據源定義 wren ui 連接資訊類型

4. 更新 `wren-ui/src/apollo/server/schema.ts` 中的 GraphQL Schema，以便在 UI 中使用新數據源
  - 將新數據源添加到 `DataSource` 枚舉中

5. 更新 `wren-ui/src/apollo/server/types/dataSource.ts` 中的類型定義
  - 將新數據源添加到 `DataSourceName` 枚舉中

#### 前端 (Frontend)
1. 準備數據源標誌 (Logo)：
   - 圖片尺寸應為 `40 x 40` px
   - 建議使用 SVG 格式
   - 確保標誌在 `30px` 的容器內置中，以保持格式一致

   範例：

   <img src="./misc/logo_template.jpg" width="120">

2. 建立數據源表單模板：
   - 在 `wren-ui/src/components/pages/setup/dataSources` 中，添加名為 `${dataSource}Properties.tsx` 的新檔案
   - 在該檔案中實作數據源表單模板

3. 設置數據源模板：
   - 前往 `wren-ui/src/utils/dataSourceType.ts`
   - 添加新的數據源圖片、名稱、屬性
   - 更新必要檔案以包含新數據源的模板設定

4. 更新數據源列表：
   - 將新數據源添加到 `wren-ui/src/utils/enum/dataSources.ts` 中的 `DATA_SOURCES` 枚舉
   - 更新 `wren-ui/src/components/pages/setup/` 中的相關檔案以包含新數據源
   - 確保 `wren-ui/src/apollo/server/adaptors/ibisAdaptor.ts` 能處理新數據源

5. 測試新連接器：
   - 確保新數據源出現在 UI 中
   - 驗證表單是否能正確運作
   - 測試與新數據源的連接

