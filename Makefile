tag = remote_archifiltre
path = /usr/share/nginx/html

all: install

install: cleanFolder pullDockerImage
	sudo docker run \
		-d \
		--name=$(tag) \
		$(tag) sh
	sudo docker cp $(tag):$(path) ./$(tag)
	sudo chmod -R 777 ./$(tag)
	cp -r ./$(tag)/* .
	rm -fr ./$(tag)
	sudo docker container stop $(tag)
	sudo docker container rm $(tag)


pullDockerImage:
	sudo docker build \
		--network=host \
		--tag=$(tag) \
		https://github.com/jeanbaptisteassouad/cheapExp.git#v8


cleanFolder:
	find . -maxdepth 1 \
		-not -path '\.' \
		-not -path '\./\.*' \
		-not -path '\./Makefile' \
		-not -path '\./README.md' \
		-not -path '\./LICENSE' \
		| xargs -I {} rm -fr {}

