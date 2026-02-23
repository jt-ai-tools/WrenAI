#!/bin/bash
# 排除 .git, node_modules, .venv, venv 等常見忽略目錄
find . -name "*.md" \
    -not -path "*/.*" \
    -not -path "*/node_modules/*" \
    -not -path "*/.venv/*" \
    -not -path "*/venv/*" \
    -not -path "*/dist/*" \
    -not -path "*/build/*" \
    | sed 's|^\./||' | sort
