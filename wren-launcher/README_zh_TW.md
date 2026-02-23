## 如何編譯 (Build)
```bash
# Mac
go build main.go
# Windows
env GOOS=windows GOARCH=amd64 go build main.go
```

## 代碼質量 (Code Quality)
```bash
make check  # 執行所有檢查 (fmt, vet, lint)
make test   # 執行測試
make fmt    # 格式化代碼
make vet    # 執行 go vet
make lint   # 執行 golangci-lint
```

## 持續整合 (Continuous Integration)

本專案使用 GitHub Actions 進行 CI/CD。工作流將在以下情況自動執行：

- **推送 (Push) 至 main 分支**：執行所有檢查與測試。
- **帶有 `launcher` 標籤的 Pull Request**：當 PR 被貼上此標籤時執行所有檢查與測試。
- **手動觸發**：可透過 GitHub Actions UI 手動觸發。

### CI 任務內容：

1. **Lint 與測試**：
   - 代碼格式檢查 (Formatting check)
   - Go vet 分析
   - golangci-lint 檢查
   - 單元測試
   - 所有質量檢查

2. **安全掃描**：
   - Gosec 安全分析
   - Go 模組驗證

## 如何更新依賴項目

```bash
# 更新單一依賴項目
go get example.com/some/package@latest

# 更新所有依賴項目
go get -u ./...

# 清理並確保模組檔案正確
go mod tidy

# 驗證更新
go test ./...
```
