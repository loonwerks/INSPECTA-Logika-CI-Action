#! /bin/bash

set -Eeuxo pipefail

: "${sysmlv2_files:=[ \"system/Platform.sysml\", \"system/SW.sysml\" ]}"
: "${sourcepaths:=[ \"system\" ]}"
: "${exclude_sourcepaths:=}"
: "${feedback:=}"
: "${integration_feedback_only:=}"
: "${parseable_messages:=true}"
: "${approximation_options:=}"
: "${control_options:=}"
: "${logging_options:=}"
: "${optimization_options:=}"
: "${path_splitting_options:=}"
: "${rewriting_options:=}"
: "${smt2_options:=}"
: "${report_filename:=logika-report.json}"
: "${GITHUB_WORKSPACE:=/home/runner/work}"

docker run --rm -v $1:${GITHUB_WORKSPACE} \
    -v ./:/home/runner \
    -e GITHUB_WORKSPACE=${GITHUB_WORKSPACE} \
    -e GITHUB_OUTPUT='/dev/stdout' \
    -w ${GITHUB_WORKSPACE} \
    --entrypoint /home/runner/entrypoint.sh \
    ghcr.io/loonwerks/inspecta-ci-action-container:master-v4.20260217.a747d3e6 \
    "${sysmlv2_files}" "${sourcepaths}" "${exclude_sourcepaths}" "${feedback}" "${integration_feedback_only}" \
    "${parseable_messages}" "${approximation_options}" "${control_options}" \
    "${logging_options}" "${optimization_options}" "${path_splitting_options}" \
    "${rewriting_options}" "${smt2_options}" "${report_filename}"

