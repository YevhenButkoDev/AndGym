#!/bin/bash

# ===== CONFIGURATION =====
APP_NAME="and-gym-server"
APP_ID="c775dc4b-a5a6-4ac0-a175-39911d5af4cf"
DOCKER_IMAGE="registry.digitalocean.com/and-gym/and-gym-server-linux"
TAG="latest"
DO_API_TOKEN="secret"
REPOSITORY="and-gym-server-linux"


# ===== Step 1: Build Docker image =====
echo "📦 Building Docker image..."
docker build --platform=linux/amd64 -f server/docker/Dockerfile -t $DOCKER_IMAGE:$TAG .
docker tag $DOCKER_IMAGE:$TAG $DOCKER_IMAGE

# ===== Step 2: Authenticate with DigitalOcean registry =====
echo "🔐 Logging into DigitalOcean registry..."
doctl registry login --access-token $DO_API_TOKEN

## ===== Step 3: Push new image =====
## WARNING: This deletes the current image from the registry!
echo "🚀 Pushing image to registry..."
docker push $DOCKER_IMAGE

## ===== Step 4: Remove old remote image =====
echo "🧹 Deleting old image..."

# Get list of all digests with their tags
DIGESTS=$(doctl registry repository list-manifests "$REPOSITORY" --output json)

# Loop through each digest
echo "$DIGESTS" | jq -c '.[]' | while read -r manifest; do
  DIGEST=$(echo "$manifest" | jq -r '.digest')
  TAGS=$(echo "$manifest" | jq -r '.tags // [] | join(",")')

  if [ -z "$TAGS" ]; then
    echo "🗑️ Deleting untagged digest: $DIGEST"
    doctl registry repository delete-manifest "$REPOSITORY" "$DIGEST" --force
  else
    echo "✅ Keeping tagged digest: $DIGEST (tags: $TAGS)"
  fi
done

echo "🎉 Done. Untagged images removed."
echo "🧹 Cleaning Garbage..."
doctl registry garbage-collection start --access-token $DO_API_TOKEN --force

## ===== Step 5: Trigger redeploy =====
echo "♻️ Triggering redeploy of App Platform..."
curl -X POST "https://api.digitalocean.com/v2/apps/$APP_ID/deployments" \
     -H "Authorization: Bearer $DO_API_TOKEN" \
     -H "Content-Type: application/json"

echo "✅ Deployment triggered."