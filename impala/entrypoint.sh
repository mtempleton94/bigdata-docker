#!/bin/bash

/etc/init.d/impala-state-store start
/etc/init.d/impala-catalog start
/etc/init.d/impala-server start

echo
echo "===================================================="
echo "================== Impala Started =================="
echo "===================================================="
echo

# Run health check on running processes
while sleep 60; do
  ps aux |grep statestored |grep -q -v grep
  PROCESS_1_STATUS=$?
  if [ $PROCESS_1_STATUS -ne 0 ]; then
    echo "ERROR: IMPALA STATESTORE HAS STOPPED."
    exit 1
  fi
  ps aux |grep catalogd |grep -q -v grep
  PROCESS_2_STATUS=$?
  if [ $PROCESS_2_STATUS -ne 0 ]; then
    echo "ERROR: IMPALA CATALOG HAS STOPPED."
    exit 1
  fi
  ps aux |grep impalad |grep -q -v grep
  PROCESS_3_STATUS=$?
  if [ $PROCESS_3_STATUS -ne 0 ]; then
    echo "ERROR: IMPALA SERVER HAS STOPPED."
    exit 1
  fi

done
