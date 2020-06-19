FROM python:3-slim

RUN apt-get update
RUN apt-get install -y jq
RUN pip install oci-cli

WORKDIR /oic
copy scripts/* ./
copy README.md ./

ENTRYPOINT /bin/bash