FROM python:3.9-alpine

RUN apk add --no-cache --virtual builddeps gcc libffi-dev musl-dev \
 && pip --no-cache-dir install aws-sam-cli awscli                  \
 && apk del builddeps

ENV SAM_CLI_TELEMETRY=0

RUN apk add --no-cache bash docker git go

WORKDIR /ssosync

COPY build.sh .
