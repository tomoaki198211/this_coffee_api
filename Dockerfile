# 既存のプロジェクトのバージョンに合わせる！
FROM ruby:3.0.1

# 起動させるためのパッケージを取得
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    # `build-essential`は開発に必須のビルドツールを提供しているパッケージ
    build-essential \
    postgresql-client \
    nodejs \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && apt-get install -y nodejs
RUN npm install --global yarn
# 作業用のディレクトリを作成(存在しない場合は勝手に作成してくれる)
WORKDIR /api

#既存railsプロジェクトをコンテナ内にコピー
COPY . /api

# ホストのGemfile達をコンテナ内にコピー
# COPY Gemfile /api/Gemfile
# COPY Gemfile.lock /api/Gemfile.lock
RUN bundle config set force_ruby_platform true
RUN gem install bundler
RUN bundle install


# entrypoint.shをコピーし、実行権限を与える
COPY entrypoint.sh /usr/bin/
# chmodコマンドはファイルやディレクトリに権限設定するコマンド。`+`は後に記述した権限を付加する。`x`は実行権限。
# つまり今回は全てのユーザに該当ファイルの実行権限を付与する。
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
# `EXPOSE <ポート>`はコンテナ実行時に<ポート>にリッスンするよう命令するコマンド。
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
