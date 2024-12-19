.PHONY: $(MAKECMDGOALS)
.EXPORT_ALL_VARIABLES:

# -------------- Install --------------
PLAYBOOK?=setup.yaml
install:																					## Run the entire installation process
	./src/install.sh ${PLAYBOOK}

install/casks: 																				## Install Homebrew casks
	./src/install_casks.sh

run_playbook:																				## Run the playbook
	ansible-playbook -i inventory/hosts setup.yaml

# -------------- Image --------------

IMAGE_REGISTRY=docker.io
IMAGE_REPOSITORY=bamaas/devcontainer
IMAGE_TAG=$(shell if [ "${PLAYBOOK}" != "setup.yaml" ]; then echo "latest-$(basename ${PLAYBOOK} .yaml)"; else echo "latest"; fi)
IMAGE?=${IMAGE_REPOSITORY}:${IMAGE_TAG}

image/build:																				## Build a container image
	docker build \
	-t ${IMAGE} \
	--build-arg PLAYBOOK=${PLAYBOOK} \
	.

image/push:																					## Push a container image
	docker push ${IMAGE}

image/run:																					## Run the devcontainer image
	docker run \
	-it \
	--rm \
	--name devcontainer \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v ${PWD}:/src \
	${IMAGE}

image/tag:																					## Tag the image as latest
	docker tag \
	${IMAGE_REGISTRY}/${IMAGE_REPOSITORY}:${OLD_TAG} \
	${IMAGE_REGISTRY}/${IMAGE_REPOSITORY}:${NEW_TAG}