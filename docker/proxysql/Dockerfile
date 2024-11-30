FROM --platform=linux/arm64 proxysql/proxysql:2.7.1

RUN apt update && apt install -y --no-install-recommends gettext

# 必要なファイルをコピー
COPY ./proxysql.cnf.template /tmp/proxysql.cnf.template
COPY ./init_container.sh /usr/local/bin/init_container.sh

# スクリプトに実行権限を付与
RUN chmod +x /usr/local/bin/init_container.sh

# ポートを公開
EXPOSE 6033

# init_container.shを起動
CMD ["/usr/local/bin/init_container.sh"]