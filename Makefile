.PHONY: $(MAKECMDGOALS)
.EXPORT_ALL_VARIABLES:

# -------------- Image --------------

IMAGE_REGISTRY=docker.io
IMAGE_REPOSITORY=bamaas/devcontainer
IMAGE_TAG?=latest
IMAGE?=${IMAGE_REPOSITORY}:${IMAGE_TAG}

image/build:																				## Build a container image
	docker build -t ${IMAGE} .

image/push:																					## Push a container image
	docker push ${IMAGE}

run_playbook:																				## Run the playbook
	ansible-playbook -i inventory/hosts playbook.yml

install:
	./src/install.sh