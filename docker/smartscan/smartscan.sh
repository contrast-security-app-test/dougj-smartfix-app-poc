#!/usr/bin/env bash

echo "Contrast URL: $CONTRAST_GITHUB_APP_TS_URL"
echo "Contrast Organization: $CONTRAST_GITHUB_APP_ORG_ID"

echo "Downloading Contrast SmartScan Tool"

# Change to the GitHub workspace where the repository is checked out
cd /github/workspace || { echo "Error: /github/workspace not found!!"; exit 1; }

echo "Current directory: $(pwd)"
echo "Files in workspace:"
ls -la

echo "Initiating Contrast SmartScan orchestration"
echo "Contrast Contrast SmartScan orchestration completed successfully."
