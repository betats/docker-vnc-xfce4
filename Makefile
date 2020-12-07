build:
	docker build --tag ff .

build-nocache:
	docker build --no-cache --tag ff .

start:
	docker run -it --rm -v $(PWD)/homedir:/home/user/ -p 5900:5900 ff
