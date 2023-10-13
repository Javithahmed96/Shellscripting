# Makefile for Docker build

# Define Docker image name and version
IMAGE_NAME ?= myapp
IMAGE_VERSION ?= latest

PYTHON_VERSION ?= 3.9

# Define Dockerfile location
DOCKERFILE := Dockerfile

# Build the Docker image
build:
	docker build --build-arg PYTHON_VERSION=$(PYTHON_VERSION) -t $(IMAGE_NAME):$(IMAGE_VERSION) -f $(DOCKERFILE) .

# Push the Docker image to a Docker registry (optional)
push:
	docker push $(IMAGE_NAME):$(IMAGE_VERSION)

# Remove the Docker image
clean:
	docker rmi -f $(IMAGE_NAME):$(IMAGE_VERSION)

