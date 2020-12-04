build:
	docker build --no-cache --tag ff .

start:
	docker run -it --rm -v $(PWD)/xfce4:/root/.config/xfce4:ro -p 127.0.0.1:5900:5900 ff

editor:
	docker run -it --rm -v $(PWD)/xfce4:/root/.config/xfce4 -p 127.0.0.1:5900:5900 ff
