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

Will generate user `admin@jrf.org.tw` with password `P@ssw0rd` and items data.


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
brew install postgis
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

Responsive Image
================

- helper & syntax

```slim
= rwd_image\
  src: fallback_image_path, # The smallest image
  srcset: [\
    path_to_image_whose_width_is_280px 280w,
    path_to_image_whose_width_is_540px 540w,
    path_to_image_whose_width_is_780px 780w,
    ...\
  ],
  alt: alt_text,
  class: appended_classname
```

- syntax of `srcset` Array's elements

```ruby
"#{path_to_image} #{width of image without 'px'}w"
```

LICENSE
=================
This project is release under MIT License.
