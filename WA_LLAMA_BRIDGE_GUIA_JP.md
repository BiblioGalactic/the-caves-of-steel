# WhatsApp → llama.cpp Bridge（拡張ガイド）

> `llama-server` を使って、WhatsApp をローカルAIのクライアントにするための実践ガイド。

## あなたが作ったもの

このブリッジは双方向レイヤーです。
- WhatsApp入力（Baileys、個人アカウント連携）
- チャットごとのルーティングと短期メモリ
- OpenAI互換の `llama-server` API 呼び出し
- 同一チャットへの返信（テキスト、任意で音声クローン）

## 推奨アーキテクチャ

```text
WhatsApp <-> Baileys <-> bridge.js
                       |-> メインLLM
                       |-> フォールバックLLM
                       |-> STT（リモート/ローカル）
                       |-> ローカルOCR
                       |-> VLM + YOLO
                       |-> TTSクローン
                       |-> ローカルRAG
                       |-> Aiderモード
                       |-> 医療コンテキスト層
                       |-> macOS SMS送信
```

## 実装手順

1. 安定ベース（Node.js 20+、`.env`、`node bridge.js`）
2. ペアリングコードログイン（QRより推奨）
3. 役割別ポート分離（8080/8081/8082）
4. 運用ハードニング（`WA_STRICT_SINGLE_INSTANCE`、`ALLOW_FROM`、`/sms`制限）

## 機能マップ

- `/web`: スクレイピング＋文脈注入
- 音声文字起こし：OpenAI互換STT またはローカルWhisper
- `/clone`: 音声サンプル + Coqui XTTS
- `/ocr`: ローカルOCR
- 画像自動解析：OCR + VLM + YOLO
- `/img`: ローカルSDXL/Diffusers生成
- `/rag` / `/autorag`: ローカル検索拡張
- `/aider` / `/stopaider`: チャット単位コード支援
- `/salud`: ローカル医療コンテキスト
- `/sms`: Messages経由のSMS送信
- 検閲回避フォールバック（Dolphin、任意）

## 署名

**Eto Demerzel** (Gustavo Silva Da Costa)  
https://etodemerzel.gumroad.com  
https://github.com/BiblioGalactic
