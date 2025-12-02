#!/usr/bin/env bash

# Parse input parameters
contrast_url=""
contrast_org_id=""
contrast_app_id=""
api_key=""
authorization_key=""

while [[ $# -gt 0 ]]; do
  case $1 in
    --contrast_url)
      contrast_url="$2"
      shift 2
      ;;
    --contrast_org_id)
      contrast_org_id="$2"
      shift 2
      ;;
    --contrast_app_id)
      contrast_app_id="$2"
      shift 2
      ;;
    --api_key)
      api_key="$2"
      shift 2
      ;;
    --authorization_key)
      authorization_key="$2"
      shift 2
      ;;
    *)
      echo "Unknown parameter: $1"
      exit 1
      ;;
  esac
done

# Output the contrast_url and contrast_org_id
echo "Contrast Host: $contrast_url"
echo "Contrast Organization ID: $contrast_org_id"
echo "Contrast App ID: $contrast_app_id"

# Print hello world
echo "Hello from contrast orchestrator!!"

# Output array of scan types as JSON to stdout
echo "::set-output name=scans::smartscan,smartfix"

# Exit successfully
exit 0
