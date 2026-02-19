FROM ghcr.io/loonwerks/inspecta-ci-action-container:master-v4.20260217.a747d3e6

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /root/logika.sh

RUN apt-get update -q \
    && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y --no-install-recommends vim \
    && apt-get clean autoclean \
    && apt-get autoremove --yes

RUN chmod +x /root/logika.sh

RUN mkdir -p /github/workspace

WORKDIR /github/workspace

RUN git clone -b feb-2026 https://github.com/loonwerks/INSPECTA-demo.git

ENV GITHUB_WORKSPACE=/github/workspace/INSPECTA-demo
ENV GITHUB_OUTPUT=GITHUB_OUTPUT.txt

WORKDIR /github/workspace/INSPECTA-demo

# /root/logika.sh "" "[ \"system\" ]" "" "" "true" "" "" "" "" "" "" "" "logika-report.json"
