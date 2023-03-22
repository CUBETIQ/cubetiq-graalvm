BASE_IMAGE=cubetiq/graalvm

19:
	docker build --build-arg SDK_JAVA_VERSION=22.3.r19-grl -f Dockerfile . -t $(BASE_IMAGE):19 -t $(BASE_IMAGE):latest

17:
	docker build --build-arg SDK_JAVA_VERSION=21.3.0.r17-grl -f Dockerfile . -t $(BASE_IMAGE):17

11:
	docker build --build-arg SDK_JAVA_VERSION=21.2.0.r11-grl -f Dockerfile . -t $(BASE_IMAGE):11


publish:
	docker push $(BASE_IMAGE):latest
	docker push $(BASE_IMAGE):19
	docker push $(BASE_IMAGE):17
	docker push $(BASE_IMAGE):11

# Run all build
build: 19 17 11 publish