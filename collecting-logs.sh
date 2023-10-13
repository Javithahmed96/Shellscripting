#!/bin/bash

# Define the namespace and pod names for all ns and pods
NAMESPACE="*"
POD="*"

# Define the log directory on the local machine
LOG_DIR="$HOME/logs"

# Create a timestamp for the log files
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Create a directory for the logs
LOGS_DIR="$LOG_DIR/logs-$TIMESTAMP"
mkdir -p "$LOGS_DIR"

# Check if pod and namespace arguments are provided
if [ "$#" -eq 2 ]; then
    NAMESPACE="$1"
    POD="$2"
    kubectl logs -n "$NAMESPACE" "$POD" > "$LOGS_DIR/$NAMESPACE-$POD-logs.txt"
elif [ "$#" -eq 0 ]; then
    # If no arguments are provided, collect logs from all pods in the default namespace
    NAMESPACE="default"
    all_pods=$(kubectl get pods -n "$NAMESPACE" --no-headers -o custom-columns="NAMESPACE:.metadata.namespace,POD:.metadata.name" | tr -s ' ' | cut -d ' ' -f 1,2)
    while read -r line; do
        namespace=$(echo "$line" | cut -d ' ' -f 1)
        pod=$(echo "$line" | cut -d ' ' -f 2)
        kubectl logs -n "$namespace" "$pod" > "$LOGS_DIR/$namespace-$pod-logs.txt"
    done <<< "$all_pods"
else
    echo "Usage: $0 [<NAMESPACE> <POD>]"
    exit 1
fi


# Compress the log files into a zip archive
zip -r "$LOG_DIR/logs-$TIMESTAMP.zip" "$LOGS_DIR"

echo "Logs collected and compressed in $LOG_DIR/logs-$TIMESTAMP.zip"
