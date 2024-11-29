#!/bin/bash

# エラーハンドリング
set -e

# 環境変数の確認
if [ -z "$MYSQL_USER" ] || [ -z "$MYSQL_PASSWORD" ] || [ -z "$MYSQL_ROOT_PASSWORD" ]; then
    echo "Error: Required environment variables are not set"
    echo "Required: MYSQL_USER, MYSQL_PASSWORD, MYSQL_ROOT_PASSWORD"
    exit 1
fi

# SQLコマンドを実行
mysql -h mysql-master -u root -p"${MYSQL_ROOT_PASSWORD}" << EOF
CREATE DATABASE IF NOT EXISTS sample;
USE sample;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL
);

INSERT INTO users (name, email) VALUES ('John Doe', 'john@example.com');

DROP USER IF EXISTS '${MYSQL_USER}'@'%';
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED WITH mysql_native_password BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON sample.* TO '${MYSQL_USER}'@'%';
GRANT REPLICATION SLAVE ON *.* TO '${MYSQL_USER}'@'%';
GRANT REPLICATION CLIENT ON *.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "Database initialization completed successfully"