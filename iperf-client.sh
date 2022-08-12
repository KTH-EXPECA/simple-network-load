#!/usr/bin/env bash

set -o pipefail;

# set default values for optional environment variables
IPERF_LOGFILE=${IPERF_LOGFILE:-"/dev/null"};
IPERF_START_DELAY=${IPERF_START_DELAY:-0};
IPERF_MAX_RETRIES=${IPERF_MAX_RETRIES:-10};
IPERF_CONN_TIMEOUT=${IPERF_CONN_TIMEOUT:-1000}
IPERF_SERVER_PORT=${IPERF_SERVER_PORT:-5201};
IPERF_USE_UDP=${IPERF_USE_UDP:-true}

IPERF_TRANSPORT_FLAG=$("${IPERF_USE_UDP}" && echo "-u" || echo "")

echo "Sleeping ${IPERF_START_DELAY} seconds before start..." | tee "${IPERF_LOGFILE}";
sleep "${IPERF_START_DELAY}"

for _ in $(seq 1 "${IPERF_MAX_RETRIES}"); do
  iperf3 \
    --forceflush \
    -V \
    -c "${IPERF_SERVER_ADDR}" \
    -p "${IPERF_SERVER_PORT}" \
    "${IPERF_TRANSPORT_FLAG}" \
    -b "${IPERF_BITRATE}" \
    -t "${IPERF_TIME}" \
    --connect-timeout "${IPERF_CONN_TIMEOUT}" \
    | tee -a "${IPERF_LOGFILE}";
  if [ $? -ne 1 ]; then
    break;
  fi
done

set +o pipefail