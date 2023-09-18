.DEFAULT_GOAL := help

build:
	zig build-lib src/main.zig -target wasm32-freestanding -dynamic -rdynamic -O ReleaseFast
	mv main.wasm site/wasm/main.wasm
	mv main.wasm.o site/wasm/main.wasm.o

run-fs-server:
	python -m http.server 8000 --directory site &

stop-fs-server:
	ps aux | grep python | grep http.server | awk '{print $$2}' | xargs kill -9

help:
	@echo "Usage: make [target] ..."
	@make -qpRr | egrep -e '^[a-z].*:$$' | sed -e 's~:~~g' | sort

