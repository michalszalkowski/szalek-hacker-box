all: help

pull:
	@echo "Pulling docker image..."
	@docker pull szalek/hacker-box

build:
	@echo "Building docker container..."
	@docker build -t szalek/hacker-box .

install-stub:
	@echo "Installing hacker-box to /usr/local/bin"
	@cp ./hacker-box /usr/local/bin && chmod +x /usr/local/bin/hacker-box

remove-stub:
	@echo "Removing hacker-box to /usr/local/bin"
	@rm -f /usr/local/bin/hacker-box

interactive:
	@docker run --rm -it --entrypoint /bin/bash szalek/hacker-box

help:
	@echo ""
	@echo "hacker-box"
	@echo "  make pull          - pull docker image"
	@echo "  make build         - build docker image"
	@echo "  make help          - show that help"
	@echo "  make install-stub  - link hacker-box with host machine"
	@echo "  make remove-stub   - unlink hacker-box with host machine"
	@echo "  make interactive   - play with tools inside box"
	@echo ""