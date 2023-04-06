#!/bin/bash -eu
id="sam-$(uuidgen)"
id="$(printf ${id} | tr '[:upper:]' '[:lower:]')"

cleanup () {
	docker stop "${id}" || true
	docker rm "${id}" || true
}
trap cleanup SIGINT SIGTERM EXIT

docker build --tag "${id}" .
docker create --tty                                                  \
	--interactive                                                \
	--name "${id}"                                               \
	--entrypoint=/bin/bash                                       \
	--env AWS_REGION=${AWS_REGION}                               \
	--env AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION}               \
	--env AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}                 \
	--env AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}         \
	--env AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}                 \
	--env AWS_CREDENTIAL_EXPIRATION=${AWS_CREDENTIAL_EXPIRATION} \
	"${id}"
docker cp . ${id}:/ssosync
docker start --interactive --attach "${id}"
