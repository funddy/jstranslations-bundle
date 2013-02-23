all: build test-build

build:
	cake build

test-build:
	coffee -c -o test/lib test/src

test-watch:
	coffee -o test/lib -cw test/src

.PHONY: build test-build test-watch