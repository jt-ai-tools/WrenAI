# 歡迎來到 Wren AI 服務貢獻指南

感謝您投入時間為我們的專案做出貢獻！本文件提供了貢獻至 Wren AI 服務的相關準則。

## 新貢獻者指南

- 要了解專案概覽，請閱讀[核心概念](https://docs.getwren.ai/oss/concept/wren_ai_service)。
- 要設置本地開發環境，請閱讀[環境設置](./README_zh_TW.md#環境設置)與[啟動開發服務](./README_zh_TW.md#為開發環境啟動服務)。
- 為了更快速地理解代碼庫，我們為您準備了[代碼設計介紹](./docs/code_design_zh_TW.md)。

## 開始行動

### Issues

#### 建立新的 Issue

如果您發現問題，請先搜尋是否已存在相同的 Issue。如果不存在相關 Issue，您可以開啟一個新的 [Issue](https://github.com/Canner/WrenAI/issues/new/choose)。

#### 解決 Issue

瀏覽我們的[現有 Issues](https://github.com/Canner/WrenAI/issues?q=is%3Aopen+is%3Aissue+label%3Amodule%2Fai-service) 以尋找您感興趣的項目。一般而言，我們不會指派 Issue 給任何人。如果您找到想處理的 Issue，歡迎直接提交修復的 PR。

### Pull Request (PR)

完成變更後，請建立一個 Pull Request (PR)。
- 填寫描述說明，以便我們審核您的 PR。
- 如果您是在解決某個 Issue，請記得將 [PR 連結至 Issue](https://docs.github.com/en/issues/tracking-your-work-with-issues/linking-a-pull-request-to-an-issue)。
- 為您的 PR 添加 `module/ai-service` 標籤。
- 勾選[允許維護者編輯 (allow maintainer edits)](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/allowing-changes-to-a-pull-request-branch-created-from-a-fork)，以便分支能為了合併而進行更新。
  提交 PR 後，Canner 團隊成員將會審核您的提案。我們可能會提出問題或要求額外的資訊。
- 在 PR 合併前，我們可能會要求進行變更，方式包括[建議的變更 (suggested changes)](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/incorporating-feedback-in-your-pull-request) 或 PR 評論。您可以直接透過 UI 採納建議的變更。任何其他變更請在您的 Fork 中進行，然後提交至您的分支。
- 當您更新 PR 並應用變更後，請將每個對話標記為[已解決 (resolved)](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/commenting-on-a-pull-request#resolving-conversations)。
- 請務必在 PR 標題添加以下前綴之一，以便我們的 CI 自動擷取此 PR 的變更日誌 (Changelog)：
  - `feat(wren-ai-service)`: 用於新功能
  - `chore(wren-ai-service)`: 用於維護工作
  - `fix(wren-ai-service)`: 用於 Bug 修復
- 如果您遇到任何合併問題，請參考此 [Git 教學](https://github.com/skills/resolve-merge-conflicts) 以協助您解決合併衝突。

### 您的 PR 已合併！

恭喜！:tada::tada: Canner 團隊感謝您的付出 :sparkles:。

一旦您的 PR 被合併，您的貢獻將會包含在下一個版本中。

現在您已正式成為 Canner 社群的一員。

## 如何添加您偏好的 LLM、Embedder 或 Document Store

- 請閱讀[此文件以獲取更多詳細資訊](https://docs.getwren.ai/oss/ai_service/guide/custom_llm#adding-a-custom-llm-embedder-or-document-store-to-wren-ai)。
