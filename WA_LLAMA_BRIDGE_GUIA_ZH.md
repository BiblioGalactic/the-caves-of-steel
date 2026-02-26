# WhatsApp → llama.cpp Bridge（扩展指南）

> 使用 `llama-server`，把 WhatsApp 变成你的本地 AI 客户端的实战手册。

## 你构建了什么

这个 bridge 是一个双向控制层：
- 来自 WhatsApp 的输入（Baileys，个人账号绑定）
- 按聊天维度路由与短期记忆
- 调用 OpenAI 兼容的 `llama-server` API
- 在同一聊天中回复（文本，或可选语音克隆）

## 推荐架构

```text
WhatsApp <-> Baileys <-> bridge.js
                       |-> 主 LLM
                       |-> 备用 LLM
                       |-> STT（远端/本地）
                       |-> 本地 OCR
                       |-> VLM + YOLO
                       |-> TTS 语音克隆
                       |-> 本地 RAG
                       |-> Aider 模式
                       |-> 医疗上下文层
                       |-> macOS 短信发送
```

## 实施顺序

1. 先建稳定基础（Node.js 20+、`.env`、`node bridge.js`）
2. 使用配对码登录（优先于 QR）
3. 端口分层（8080 主模型，8081 Aider，8082 Dolphin）
4. 运行加固（`WA_STRICT_SINGLE_INSTANCE`、`ALLOW_FROM`、`/sms` 限权）

## 功能映射

- `/web`：网页抓取 + 上下文注入
- 音频转写：OpenAI兼容 STT 或本地 Whisper
- `/clone`：语音样本 + Coqui XTTS
- `/ocr`：本地 OCR
- 图片自动分析：OCR + VLM + YOLO
- `/img`：本地 SDXL/Diffusers 出图
- `/rag` / `/autorag`：本地检索增强
- `/aider` / `/stopaider`：按聊天启停代码助手
- `/salud`：本地医疗上下文
- `/sms`：通过 macOS Messages 发短信
- 可选反审查回退（Dolphin）

## 签名

**Eto Demerzel** (Gustavo Silva Da Costa)  
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
