#!/usr/bin/env bash

set -o pipefail;

# set default values for optional environment variables
IPERF_LOGFILE=${IPERF_LOGFILE:-"/dev/null"};
IPERF_SERVER_PORT=${IPERF_SERVER_PORT:-5201};
IPERF_LOG_HEADER=${IPERF_LOG_HEADER:-""}

echo "${IPERF_LOG_HEADER}" | tee -a "${IPERF_LOGFILE}";
iperf3 --forceflush -V -s -p "${IPERF_SERVER_PORT}" | tee -a "${IPERF_LOGFILE}";
set +o pipefail;

