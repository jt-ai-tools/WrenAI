
<p align="center" id="top">
  <a href="https://getwren.ai/?utm_source=github&utm_medium=title&utm_campaign=readme">
    <picture>
      <source media="(prefers-color-scheme: light)" srcset="./misc/wrenai_logo.png">
      <img src="./misc/wrenai_logo_white.png" width="300px">
    </picture>
    <h1 align="center">Wren AI - 開源 GenBI 代理 (Agent)</h1>
  </a>
</p>

<p align="center">
  <a href="README.md">English</a> | <b>繁體中文</b>
</p>

<p align="center">
  <a aria-label="Follow us on X" href="https://x.com/getwrenai">
    <img alt="" src="https://img.shields.io/badge/-@getwrenai-blue?style=for-the-badge&logo=x&logoColor=white&labelColor=gray&logoWidth=20">
  </a>
  <a aria-label="Releases" href="https://github.com/canner/WrenAI/releases">
    <img alt="" src="https://img.shields.io/github/v/release/canner/WrenAI?logo=github&label=GitHub%20Release&color=blue&style=for-the-badge">
  </a>
  <a aria-label="License" href="https://github.com/Canner/WrenAI/blob/main/LICENSE">
    <img alt="" src="https://img.shields.io/github/license/canner/WrenAI?color=blue&style=for-the-badge">
  </a>
  <a href="https://docs.getwren.ai">
    <img src="https://img.shields.io/badge/docs-online-brightgreen?style=for-the-badge" alt="Docs">
  </a>
  <a aria-label="Join the community on GitHub" href="https://discord.gg/5DvshJqG8Z">
    <img alt="" src="https://img.shields.io/badge/-JOIN%20THE%20COMMUNITY-blue?style=for-the-badge&logo=discord&logoColor=white&labelColor=grey&logoWidth=20">
  </a>
  <a aria-label="Canner" href="https://cannerdata.com/?utm_source=github&utm_medium=badge&utm_campaign=readme">
    <img src="https://img.shields.io/badge/%F0%9F%A7%A1-Made%20by%20Canner-blue?style=for-the-badge">
  </a>
</p>

<p align="center">
  <a href="https://trendshift.io/repositories/9263" target="_blank"><img src="https://trendshift.io/api/badge/repositories/9263" alt="Canner%2FWrenAI | Trendshift" style="width: 250px; height: 55px;" width="250" height="55"/></a>
</p>

> ⚡ GenBI (Generative BI) 讓您能用自然語言查詢任何資料庫，並在幾秒鐘內生成準確的 SQL (Text-to-SQL)、圖表 (Text-to-Chart) 以及 AI 驅動的商業智能。

<p align="center">
  <img width="1920" height="1080" alt="1" src="https://github.com/user-attachments/assets/bba9d37a-33e3-49ab-b7cb-32fd6dddc8d1" />
</p>
 
## 😍 演示 (Demos)

https://github.com/user-attachments/assets/f9c1cb34-5a95-4580-8890-ec9644da4160

[觀看 GenBI 演示](https://github.com/user-attachments/assets/90ad1d35-bb1e-490b-9676-b29863ff090b)

## 🤖 特色功能

|                    | 您將獲得什麼 | 為什麼這很重要 |
|--------------------|--------------|----------------|
| **與您的數據對話** | 使用任何語言提問 → 精準的 SQL 與解答 | 大幅降低 SQL 學習門檻﻿ |
| **GenBI 洞察** | AI 撰寫的摘要、圖表與報告 | 一鍵獲取決策所需的背景資訊﻿ |
| **語義層 (Semantic Layer)** | MDL 模型編碼架構、指標與關聯 (joins) | 保持 LLM 輸出的準確性與規範化﻿ |
| **透過 API 嵌入**  | 在您的應用程式中生成查詢與圖表 ([API 文件](https://wrenai.readme.io/reference/cloud-getting-started)) | 構建自定義代理、SaaS 功能、聊天機器人﻿ ([Streamlit 線上演示](https://huggingface.co/spaces/getWrenAI/wrenai-cloud-api-demo)) |

🤩 [了解更多關於 GenBI 的資訊](https://getwren.ai/genbi?utm_source=github&utm_medium=content&utm_campaign=readme)

## 🚀 快速入門

使用 Wren AI 非常簡單，您可以在 3 分鐘內完成設置，並開始與您的數據互動！

<p align="center">
  <img width="1920" height="1080" alt="2" src="https://github.com/user-attachments/assets/6555f539-9ef2-485d-9135-0071741fda96" />
</p>

- 訪問我們的 [本地環境安裝指南](http://docs.getwren.ai/oss/installation?utm_source=github&utm_medium=content&utm_campaign=readme)。
- 訪問 [使用手冊](https://docs.getwren.ai/oss/guide/connect/overview?utm_source=github&utm_medium=content&utm_campaign=readme) 以了解更多關於如何使用 Wren AI 的資訊。
- 或者直接開始使用 [Wren AI Cloud](https://getwren.ai/?utm_source=github&utm_medium=content&utm_campaign=readme) 託管雲端服務。 ([開源版 vs. 商業版方案](https://docs.getwren.ai/oss/overview/cloud_vs_self_host))。

## 🏗️ 系統架構

<p align="center">
  <img width="1011" height="682" alt="wrenai-architecture" src="https://github.com/user-attachments/assets/e99b999f-9912-4fa7-921a-9c86b6b83354" />
</p>

👉 [了解更多關於我們的設計](https://getwren.ai/post/how-we-design-our-semantic-engine-for-llms-the-backbone-of-the-semantic-layer-for-llm-architecture?utm_source=github&utm_medium=content&utm_campaign=readme)



## 🔌 數據源 (Data Sources)

如果您的數據源未列在此處，請在我們的 [GitHub 討論區](https://github.com/Canner/WrenAI/discussions/327) 中為其投票。這將是我們決定下一個支援的數據源時非常有價值的參考。
- Athena (Trino)
- Redshift
- BigQuery
- DuckDB
- Databricks
- PostgreSQL
- MySQL
- Microsoft SQL Server
- ClickHouse
- Oracle
- Trino
- Snowflake

## 🤖 LLM 模型

Wren AI 支援與各種大型語言模型 (LLMs) 集成，包括但不限於：
- OpenAI 模型
- Azure OpenAI 模型
- DeepSeek 模型
- Google AI Studio – Gemini 模型
- Vertex AI 模型 (Gemini + Anthropic)
- Bedrock 模型
- Anthropic API 模型
- Groq 模型
- Ollama 模型
- Databricks 模型

查看 [配置範例](https://github.com/Canner/WrenAI/tree/main/wren-ai-service/docs/config_examples)!

> [!CAUTION]
> Wren AI 的表現很大程度上取決於您選擇的 LLM 能力。我們強烈建議使用最強大的可用模型以獲得最佳效果。使用能力較弱的模型可能會導致效能下降、響應時間變慢或輸出不準確。

## 📚 文件

訪問 [Wren AI 文件](https://docs.getwren.ai/oss/overview/introduction?utm_source=github&utm_medium=content&utm_campaign=readme) 以查看完整文件。

## 📪 保持聯繫？

[訂閱我們的部落格](https://www.getwren.ai/blog/?utm_source=github&utm_medium=content&utm_campaign=readme) 並 [追蹤我們的 LinkedIn](https://www.linkedin.com/company/wrenai)

## 🛠️ 貢獻方式

1.	在 Repo 按下 Star ⭐ 以示支持（這對我們很有幫助）。
2.	針對 Bug、想法或討論提出 Issue。
3.	閱讀 [貢獻指南 (Contribution Guidelines)](./CONTRIBUTING_zh_TW.md) 以了解開發設置與 PR 規範。

## ⭐️ 社群

- 加入我們 [Discord](https://discord.gg/5DvshJqG8Z) 中 1.3k+ 位開發者的行列，獲取即時協助與路線圖預覽。
- 如有任何問題，請造訪 [GitHub Issues](https://github.com/Canner/WrenAI/issues)。
- 探索我們的 [公開路線圖 (Public Roadmap)](https://wrenai.notion.site/) 以了解最新的功能開發進度與改進計畫！

請注意，我們的 [行為準則 (Code of Conduct)](./CODE_OF_CONDUCT_zh_TW.md) 適用於所有 Wren AI 社群頻道。我們**強烈建議**使用者閱讀並遵守，以避免產生不必要的影響。

## 🎉 我們的貢獻者
<a href="https://github.com/canner/wrenAI/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Canner/WrenAI" />
</a>

<p align="right">
  <a href="#top">⬆️ 回到頂部</a>
</p>
