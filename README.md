# Rails Todo App

Docker環境で動作するRuby on RailsのTodoアプリケーションです。

## 技術スタック

- Ruby 3.2.2
- Ruby on Rails 7.1
- PostgreSQL 15
- Docker / Docker Compose

## セットアップ

### 1. リポジトリのクローン

```bash
git clone <repository-url>
cd rails-todo
```

### 2. Docker環境の起動

```bash
# イメージのビルド
docker compose build

# コンテナの起動
docker compose up -d

# データベースの作成とマイグレーション
docker compose exec web rails db:create db:migrate
```

### 3. アプリケーションへのアクセス

ブラウザで http://localhost:3000 にアクセスしてください。

## 開発コマンド

```bash
# コンテナの起動
docker compose up -d

# コンテナの停止
docker compose down

# ログの確認
docker compose logs -f web

# Railsコンソール
docker compose exec web rails console

# マイグレーションの実行
docker compose exec web rails db:migrate

# テストの実行
docker compose exec web rails test
```

## 機能

- ✅ タスクの作成・編集・削除
- ✅ タスクの完了/未完了の切り替え
- ✅ タスク一覧の表示
- ✅ タスクの詳細表示
- ✅ レスポンシブデザイン

## ディレクトリ構成

```
rails-todo/
├── app/
│   ├── controllers/
│   ├── models/
│   ├── views/
│   └── assets/
├── config/
├── db/
├── docker-compose.yml
├── Dockerfile
├── entrypoint.sh
├── Gemfile
└── README.md
```

## ライセンス

MIT
