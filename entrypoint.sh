#!/bin/sh

[ ! -f /root/.ssh/config ] && {
	git config --global user.name "docker-hexo-web"
	git config --global user.email "docker-hexo-web@gmail.com"

	rm -rf /root/.ssh
	mkdir -p /root/.ssh
	cp /root/tmp/.ssh/* /root/.ssh
	rm -rf /root/tmp/.ssh/known_hosts*
	cat /root/tmp/.ssh/config | sed 's/home.*ssh/root\/.ssh/g' > /root/.ssh/config
}

echo "cmd: $1, $2, $3"
case "$1" in
	app:web-service)
		domain=$(echo $2 |  awk -F@ '{print $2}' | awk -F: '{print $1}')
		echo "domain:$domain"
		cd /root
		fping -c1 -t500 $domain
		ssh -o StrictHostKeyChecking=no $domain
		git clone $2 blog
		hexo init blog-tmp
		mv blog-tmp/node_modules git-blog
		cd blog
		npm install
		hexo generate
		hexo server -p 8010
		;;
	*)
		exec "$@"
		;;
esac
