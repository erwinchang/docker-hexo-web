BLOG	:= git@github.com:erwinchang/erwinchang.github.io.git

all: build

help:
	@echo ""
	@echo "-- Help Menu"
	@echo "  1. make build       - build the hexo image"
	@echo "  2. make release     - release the hexo image"
	@echo "  3. make web BLOG=xx - start hexo"

build:
	@docker build --tag=erwinchang/hexo-web .

release: build
	@docker build --tag=erwinchang/hexo-web:$(shell cat VERSION) .

web:
	@echo "BLOG:${BLOG}"
	@docker run -v ${HOME}/.ssh:/root/tmp/.ssh -p 8010:8010 --rm --name hexo-web -d erwinchang/hexo-web app:web-service ${BLOG}

run:
	@docker run -v ${HOME}/.ssh:/root/tmp/.ssh -p 8010:8010 -it --rm --name hexo-web erwinchang/hexo-web /bin/bash
