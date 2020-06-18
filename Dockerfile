from jpoon/oci-cli

run apt-get install -y jq

WORKDIR /oic
copy scripts/* ./
copy README.md ./
