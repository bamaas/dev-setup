test:
	docker run --rm --name wsl2-setup -v ${PWD}:/src ubuntu:22.04 /bin/bash -c "cd src && ./install.sh"
