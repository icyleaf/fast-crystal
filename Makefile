CRYSTAL_BIN ?= $(shell which crystal)
PREFIX ?= /usr/local

run: build
	./bin/fast-crystal

clean:
	rm -rf bin
	mkdir bin

build: clean
	$(CRYSTAL_BIN) build --release --no-debug -o bin/fast-crystal src/fast-crystal.cr $(CRFLAGS)
