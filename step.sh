#!/bin/bash

set -o pipefail

echo "Instabug mapping files uploader"

if [ ! -f $BITRISE_MAPPING_PATH ]; then
    echo "Mapping files not found. Did you run this step before the build step?"
    exit 1
fi

echo "Mapping files found! Uploading..."

ENDPOINT="https://api.instabug.com/api/sdk/v3/symbols_files"

STATUS=$(curl "${ENDPOINT}" --write-out %{http_code} --silent --output /dev/null -F os=iOS -F symbols_file=@"${BITRISE_DSYM_PATH}" -F application_token="${instabug_app_token}")

if [ $STATUS -ne 200 ]; then
  echo "Error while uploading mapping files"
  exit 1
fi

echo "Success! Your mapping files got uploaded successfully"

exit 0