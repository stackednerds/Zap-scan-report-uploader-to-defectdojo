#!/bin/bash

# Ensure required variables are set
if [[ -z "$DEFECTDOJO_URL" || -z "$DD_API_KEY" || -z "$ENGAGEMENT_ID" || -z "$ZAP_REPORT" ]]; then
  echo "Error: Missing required environment variables."
  exit 1
fi

TIMEOUT=120
INTERVAL=5
ELAPSED=0
while [[ ! -f "$ZAP_REPORT" && $ELAPSED -lt $TIMEOUT ]]; do
  echo "Waiting for ZAP report file: $ZAP_REPORT"
  sleep $INTERVAL
  ELAPSED=$((ELAPSED+INTERVAL))
done


# Check if the report file exists
if [[ ! -f "$ZAP_REPORT" ]]; then
  echo "Error: File '$ZAP_REPORT' not found."
  exit 1
fi

# Upload the report using DefectDojo API
curl -X POST "$DEFECTDOJO_URL/api/v2/import-scan/" \
  -H "Authorization: Token $DD_API_KEY" \
  -H "Content-Type: multipart/form-data" \
  -F "scan_type=ZAP Scan" \
  -F "file=@$ZAP_REPORT" \
  -F "engagement=$ENGAGEMENT_ID" \
  -F "active=true" \
  -F "verified=true"

echo "Scan upload request sent for: $ZAP_REPORT"
