Project Build
===============

```
bundle install
```

```
cp config/database.yml.example config/database.yml
cp config/application.yml.example config/application.yml
```

(setup database.yml & start postgresql)

```
bundle exec rake dev:build
```

memcached
===========

```
brew install memcached
```

```
memcached -d
```
