#!/bin/bash
set -e

# Railsのサーバーが起動中に残ったpidファイルを削除
rm -f /rails-app/tmp/pids/server.pid

# メインプロセスを実行
exec "$@"

