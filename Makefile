CRYSTAL_BIN ?= $(shell which crystal)
PREFIX ?= /usr/local

build:
	$(CRYSTAL_BIN) build --release -o bin/fast-crystal src/fast-crystal.cr $(CRFLAGS)

run: build
	./bin/fast-crystal