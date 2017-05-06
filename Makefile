CRYSTAL_BIN ?= $(shell which crystal)
PREFIX ?= /usr/local

run: build
	./bin/fast-crystal

clean:
	rm -rf bin
	mkdir bin

build:
	$(CRYSTAL_BIN) build --release -o bin/fast-crystal src/fast-crystal.cr $(CRFLAGS)