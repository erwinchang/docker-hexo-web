## Docker Image

此image使用git ssh下載git庫
自動生成hexo，產生web service

### Hexo Docker

build image hexo-web
```
make build
```

docker run
```
make start
```

docker web service
```
make web BLOG=git@github.com:erwinchang/erwinchang.github.io.git
```
