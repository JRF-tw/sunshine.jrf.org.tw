Project Build
===============

- make sure you have already start PostgreSql & Redis

```
bundle install
```

```
cp config/database.yml.example config/database.yml
cp config/application.yml.example config/application.yml
```

- setup database.yml & start postgresql.

```
bundle exec rake dev:build
```

Will generate user `admin@5fpro.com` with password `12341234` and items data.


Redis
================

- install

```
brew install redis
```

- start redis ( ctrl + c to stop)

```
redis-server
```

PostgreSql
=================

- install

```
brew install postgresql
brew unlink postgresql
brew link postgresql
ARCHFLAGS="-arch x86_64" gem install pg
```

- goto http://postgresapp.com/ download and start it.

- setup user & password

```
psql
```

- replace your_name & your_password

```
CREATE USER your_name WITH PASSWORD 'your_password';
CREATE DATABASE "your_name";
GRANT ALL PRIVILEGES ON DATABASE "your_name" to "your_name";
ALTER USER "your_name" WITH SUPERUSER;
```


Gulp Rails
=============================

整合 Gulp 進 Rails 的 Assets pipeline 才不用受制於 ruby sass 悲劇的效能。以下說明如何將 Gulp 整合進專案，如果沒有完成這個前置作業，可能會因為 public 資料夾內找不到 css 或 js 而出現 error。

1. 安裝 NVM
        
        curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.26.0/install.sh | bash

2. 安裝 Node

        nvm install stable

3. 安裝 Gulp 與 Bower

        npm install --global gulp bower

4. 安裝 Bower assets

        bower install

5. 安裝 Node modules

        npm install

6. 手動 compile 一次最新 assets

        gulp build

注意事項

1. assets 原始檔都在 `gulp/assets` 底下，`app/assets` 裡的是為了讓原本的 assets pipeline helper 可以使用才留下來的檔案，裡面的 code 是用來 require `public/assets` 裡的檔案用的。
1. 放在 `./gulp/assets/images/img/` 裡的圖片才會被壓縮/最佳化
2. 每次 pull 完都要 `bower install` 跟 `npm install` 才能確保 module 有安裝好，跑完記得 `gulp build` 來產生最新的 assets
3. 也可以在開發的時候在 `bundle exec rails s` 之後接著跑 `gulp`，可以結合 browserSync 並 compile 前端的 sass 跟 coffeescript。