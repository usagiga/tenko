#!/bin/bash

set -euo pipefail

if [[ -n ${DEBUG:+x} ]]; then
    set -x
fi

# ping to the url every 10 minutes.
# 
# Usage:
#     $0 [url or ipaddr]

function logln() {
    local DATE MESSAGE SEVERITY

    DATE=$(date "+%Y/%m/%d %H:%M:%S")
    MESSAGE=$1; shift
    SEVERITY=$1; shift

    echo "${DATE} [${SEVERITY}] ${MESSAGE}"
}

function main() {
    local INTERVAL PING_DEST PING_LOG ERR SEVERITY

    INTERVAL=600
    PING_DEST=${1:-example.com}
    while : ; do
        # Do ping
        ERR=0
        PING_LOG="$(ping -c 1 ${PING_DEST})" || ERR=$?

        # Cut off summary
        PING_LOG="$(echo "${PING_LOG}" | sed -nE 's/^.+ icmp_seq=1 (.+)$/\1/p')"

        # Print log
        if [[ $ERR == 0 ]]; then
            logln "OK. Took: ${PING_LOG}" "INFO"
        else
            logln "NG. Reason: ${PING_LOG}" "ERROR"
        fi

        # Wait
        sleep "${INTERVAL}"
    done
}

main "$@"
