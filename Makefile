test:
	docker run --rm -v ${PWD}:/src ubuntu:22.04 /bin/bash -c "cd src && ./install.sh"
