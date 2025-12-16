# syntax=docker/dockerfile:1
FROM ruby:3.2.2

# 必要なパッケージをインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs postgresql-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /rails-app

# Gemfileをコピーしてbundle install
COPY Gemfile Gemfile.lock ./
RUN bundle install

# アプリケーションのソースコードをコピー
COPY . .

# entrypoint.shをコピーして実行権限を付与
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# ポート3000を公開
EXPOSE 3000

# Railsサーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]
