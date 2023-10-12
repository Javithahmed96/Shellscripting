#!/bin/bash

# Define the namespace and pod names
NAMESPACE="javith"
POD="nginx-collector"

# Define the log directory on the local machine
LOG_DIR="$HOME/logs"

# Create a timestamp for the log files
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Create a directory for the logs
LOGS_DIR="$LOG_DIR/javith/nginx-collector-$TIMESTAMP"
mkdir -p "$LOGS_DIR"

# Collect the logs and save them in the logs directory
kubectl logs -n javith nginx-collector > "$LOGS_DIR/nginx-collector-logs.txt"
kubectl logs -n javith -l "run=nginx-collector" > "$LOGS_DIR/javith-logs.txt"

# Compress the log files into a tar.gz archive
tar -czvf "$LOG_DIR/logs-$TIMESTAMP.tar.gz" "$LOGS_DIR"


echo "Logs collected and compressed in $LOG_DIR/logs-$TIMESTAMP.tar.gz"

