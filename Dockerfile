FROM ubuntu:25.10

# 対話式コンソールの処理をスキップ
ENV DEBIAN_FRONTEND=noninteractive

# 使用するポートの宣言（Web/Blazor）
EXPOSE 8000

# 必要パッケージのインストール
RUN apt update && apt upgrade -y && \
    apt install -y git dotnet-sdk-8.0 && \
    apt autoremove -y && apt autoclean -y

# キャッシュ等削除
RUN rm -rf /tmp/* /var/tmp/* /root/.cache/*

# コンテナ起動時の作業ディレクトリ
WORKDIR /home/dev/github/mybrother/MyBrotherApp

# サーバ初期化後に処理したいスクリプト(entrypoint.sh内でコール)をコピー
COPY docker/scripts/postprocessing.sh /var/custom/postprocessing.sh
RUN chmod +x /var/custom/postprocessing.sh

# エントリーポイント（コンテナ起動時の動作）設定
COPY docker/scripts/entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# docker run 時のデフォルトコマンド
# docker run <image> <ip>:<port>で任意のip:portを指定可能
# CMD ["0.0.0.0:8000"]