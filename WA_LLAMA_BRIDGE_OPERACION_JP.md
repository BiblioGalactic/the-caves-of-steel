# WhatsApp → llama.cpp Bridge（運用プレイブック）

ブリッジを安定・予測可能に保つための日次運用ガイド。

## フェーズ

### フェーズA — 安定コア
- WhatsApp + メインLLM + 短期メモリ
- `/help` `/status` `/model` `/reset` を確認
- 許可送信者を制限

### フェーズB — 実用拡張
- `/web`、STT、`/ocr`、`/img`、`/rag`

### フェーズC — 高度化
- `/aider`、`/salud`、`/clone`、Dolphinフォールバック

## ポート設計

```text
8080 -> メイン会話モデル
8081 -> Aider用 DeepSeek
8082 -> Dolphin fallback
```

## 機能検証

- `/status` と `/model` が期待通り
- `/web` `/ocr` `/img` `/rag` が動作
- `/aider` の開始/停止が正常
- `/sms` が許可ユーザー限定

## よくある障害

- `conflict/replaced`: 他クライアントがセッション使用中
- STT失敗: エンドポイント/ローカル設定確認
- OCR不安定: モデル・パス確認
- Aiderでファイル不足: Git管理ファイルで再試行

## 署名

**Eto Demerzel** (Gustavo Silva Da Costa)  
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
