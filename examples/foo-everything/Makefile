BUILD_DIR=build
FINAL_EXECUTABLE=foo-everything

NAME=foo
VERSION=3.0.0

.PHONY: all clean build package

all: clean build package

clean:
	@rm -rfv $(BUILD_DIR)

build:
	@mkdir -p $(BUILD_DIR)/root/usr/local/bin
	@cp foo $(BUILD_DIR)/root/usr/local/bin/$(FINAL_EXECUTABLE)
	@echo Build successful.

package: build
	@debinate build --root $(BUILD_DIR)/root/ --output $(BUILD_DIR)/$(NAME)-$(VERSION)-all.deb --debian-dir debian
	@echo Package successful.
