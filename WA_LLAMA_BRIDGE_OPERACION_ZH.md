# WhatsApp → llama.cpp Bridge（运维手册）

用于保持 bridge 稳定、可预测的日常运维指南。

## 分阶段上线

### 阶段 A — 稳定核心
- 只启用 WhatsApp + 主 LLM + 短记忆
- 验证 `/help` `/status` `/model` `/reset`
- 限制允许发送者

### 阶段 B — 实用扩展
- `/web`、STT、`/ocr`、`/img`、`/rag`

### 阶段 C — 高级能力
- `/aider`、`/salud`、`/clone`、Dolphin 回退

## 端口设计

```text
8080 -> 主会话模型
8081 -> Aider 用 DeepSeek
8082 -> Dolphin fallback
```

## 功能验证

- `/status` 与 `/model` 正确
- `/web` `/ocr` `/img` `/rag` 可用
- `/aider` 启停正常
- `/sms` 仅授权用户可用

## 常见问题

- `conflict/replaced`：会话被其他客户端占用
- STT 失败：检查远端接口或本地配置
- OCR 不稳定：检查模型与路径
- Aider 缺文件：启用 Git 文件重试

## 签名

**Eto Demerzel** (Gustavo Silva Da Costa)  
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
