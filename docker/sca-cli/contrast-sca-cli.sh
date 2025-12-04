#!/usr/bin/env bash

echo 'Downloading Contrast SCA CLI Tool'
curl --location -o /usr/local/bin/contrast https://pkg.contrastsecurity.com/artifactory/cli/v2/latest/linux/contrast
chmod +x /usr/local/bin/contrast

# Change to the GitHub workspace where the repository is checked out
cd /github/workspace || { echo "Error: /github/workspace not found"; exit 1; }

echo "Current directory: $(pwd)"
echo "Files in workspace:"
ls -la

FULL_REPO_URL="$GITHUB_SERVER_URL/$GITHUB_REPOSITORY"
REPO_NAME=$(echo "$GITHUB_REPOSITORY" | awk -F/ '{print $2}')

echo 'Initiating Contrast SCA Fingerprint Command'
echo contrast fingerprint --api-key $CONTRAST_GITHUB_APP_API_KEY --authorization $CONTRAST_GITHUB_APP_AUTHORIZATION_KEY --organization-id $CONTRAST_GITHUB_APP_ORG_ID --host $CONTRAST_GITHUB_APP_APP_TS_URL --repository-url $FULL_REPO_URL --repository-name $REPO_NAME --external-id $CONTRAST_GITHUB_APP_INSTALLATION_ID --severity CRITICAL --timeout 600 --log
/usr/local/bin/contrast fingerprint --api-key $CONTRAST_GITHUB_APP_API_KEY --authorization $CONTRAST_GITHUB_APP_AUTHORIZATION_KEY --organization-id $CONTRAST_GITHUB_APP_ORG_ID --host $CONTRAST_GITHUB_APP_APP_TS_URL --repository-url $FULL_REPO_URL --repository-name $REPO_NAME --external-id $CONTRAST_GITHUB_APP_INSTALLATION_ID --severity CRITICAL --timeout 600 --log

if [ -f fingerPrintInfo.json ]
then
	count=`jq '. | length' fingerPrintInfo.json`

	echo "$count item(s) found in fingerprint file to audit"
	echo 'Initiating Contrast SCA Audit Command'

	for (( i=0; i<$count; i++ ))
		do
			filePath=`jq -r '.['$i'].filePath' fingerPrintInfo.json`
			repositoryId=`jq -r '.['$i'].repositoryId' fingerPrintInfo.json`
			projectGroupId=`jq -r '.['$i'].projectGroupId' fingerPrintInfo.json`
			echo "$filePath $repositoryId $projectGroupId"

			echo /usr/local/bin/contrast audit --api-key $CONTRAST_GITHUB_APP_API_KEY --authorization $CONTRAST_GITHUB_APP_AUTHORIZATION_KEY --organization-id $CONTRAST_GITHUB_APP_ORG_ID --host $CONTRAST_GITHUB_APP_TS_URL --track --repository-id $repositoryId --project-group-id $projectGroupId --file $filePath --severity CRITICAL --timeout 800 --log
			/usr/local/bin/contrast audit --api-key $CONTRAST_GITHUB_APP_API_KEY --authorization $CONTRAST_GITHUB_APP_AUTHORIZATION_KEY --organization-id $CONTRAST_GITHUB_APP_ORG_ID --host $CONTRAST_GITHUB_APP_TS_URL --track --repository-id $repositoryId --project-group-id $projectGroupId --file $filePath --severity CRITICAL --timeout 800 --log
		done
else
	echo "Contrast SCA analysis completed without running the audit command due to no supported manifests found."
fi
