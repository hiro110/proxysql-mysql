# What`s this?
ProxySQLによるMySQLの負荷分散構成を再現した環境です。

# 起動手順
- .env.example をコピーして .envにする。
- .envにそれぞれ値を入力
- その後、ビルドし起動する

```
docker-compose build
docker-compose up -d
```

# 動作確認

- TOPページ
http://localhost:5000

- ユーザ一覧
http://localhost:5000/users

- ユーザ追加
```
curl -X POST \
  -H "Content-Type: application/json" \
  -d '{"name": "hoge tarou", "email": "taro.hoge@example.com"}' \
  http://localhost:5000/users
```
