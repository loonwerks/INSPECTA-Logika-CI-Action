# Container image that runs your code
FROM ghcr.io/loonwerks/inspecta-ci-action-container:master-v4.20260219.f1d75683

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

