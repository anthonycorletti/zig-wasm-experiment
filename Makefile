.DEFAULT_GOAL := help

build:
	zig build-lib src/math.zig -target wasm32-freestanding -dynamic -rdynamic -O ReleaseFast
	zig build-lib src/gpu.zig -target wasm32-freestanding -dynamic -rdynamic -O ReleaseFast
	mv math.wasm site/wasm/math.wasm
	mv math.wasm.o site/wasm/math.wasm.o
	mv gpu.wasm site/wasm/gpu.wasm
	mv gpu.wasm.o site/wasm/gpu.wasm.o

run-wasm:
	node js/main.js

open-site:
	open site/index.html

run-fs-server:
	python -m http.server 8000 --directory site &

stop-fs-server:
	ps aux | grep python | grep http.server | awk '{print $$2}' | xargs kill -9

help:
	@echo "Usage: make [target] ..."
	@make -qpRr | egrep -e '^[a-z].*:$$' | sed -e 's~:~~g' | sort

