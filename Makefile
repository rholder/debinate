BUILD_DIR=build

NAME=debinate
VERSION=0.6.1

.PHONY: all clean build package

all: clean build package

clean:
	@rm -rfv $(BUILD_DIR)

build:
	@mkdir -p $(BUILD_DIR)/root/usr/bin
	@cp debinate $(BUILD_DIR)/root/usr/bin/
	@echo Build successful.

package: build
	@./debinate build --root $(BUILD_DIR)/root/ --output $(BUILD_DIR)/$(NAME)-$(VERSION)-all.deb --debian-dir debian
	@echo Package successful.
