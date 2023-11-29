#!/bin/bash

# Read config.yaml and set environment variables
eval $(cat config.yaml | yq eval 'export project_id=.project_id' -)
eval $(cat config.yaml | yq eval 'export key_pairs_name=.key_pairs[0].name' -)

# Check SSH Metadata
SSH_METADATA_EXISTS=$(gcloud compute project-info describe --project=${project_id} --format="value(commonInstanceMetadata.items['${key_pairs_name}'])")

if [ -n "$SSH_METADATA_EXISTS" ]; then
  echo "SSH Metadata exists!"
  echo "::set-output name=ssh_metadata_exists::true"
else
  echo "SSH Metadata does not exist."
  echo "::set-output name=ssh_metadata_exists::false"
fi
