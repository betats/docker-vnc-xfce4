start:
	docker pull ghcr.io/betats/docker-vnc-xfce4:latest
	docker run -it --rm -e TZ=Asia/Tokyo -v $(PWD)/homedir:/home/user/ -p 127.0.0.1:5900:5900 ghcr.io/betats/docker-vnc-xfce4:latest

build:
	docker build --tag ff .

build-nocache:
	docker build --no-cache --tag ff .

dev-start:
	docker run -it --rm -e TZ=Asia/Tokyo -v $(PWD)/homedir:/home/user/ -p 127.0.0.1:5900:5900 ff

.PHONY: backup
backup: homedir
	rsync -a homedir backup/homedir$(shell date +%Y%m%d%H%M)
