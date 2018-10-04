#!/bin/bash

# Create the metastore database
psql -h postgres -U postgres -c "CREATE DATABASE metastore;"
/usr/lib/hive/bin/schematool -dbType postgres -initSchema

# Start the Hive metastore
/etc/init.d/hive-metastore start

# Start Hive Server 2
/etc/init.d/hive-server2 start

echo
echo "=================================================="
echo "================== Hive Started ==================" 
echo "=================================================="
echo

# Run health check on running processes
while sleep 60; do
  ps aux |grep hive-metastore |grep -q -v grep
  PROCESS_1_STATUS=$?
  if [ $PROCESS_1_STATUS -ne 0 ]; then
    echo "ERROR: HIVE METASTORE HAS STOPPED."
    exit 1
  fi
  ps aux |grep hive-server2 |grep -q -v grep
  PROCESS_2_STATUS=$?
  if [ $PROCESS_2_STATUS -ne 0 ]; then
    echo "ERROR: HIVE SERVER HAS STOPPED."
    exit 1
  fi

done

