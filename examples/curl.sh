#!/usr/bin/env bash
# Mastodon Scraper - curl examples
# Replace YOUR_TOKEN with an Apify API token (https://console.apify.com/account/integrations).

set -euo pipefail

ACTOR="Turboextract~mastodon-posts-hashtags"
TOKEN="${APIFY_TOKEN:-YOUR_TOKEN}"

# 1. Hashtag posts in English from the past day (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "hashtags": [
      "opensource",
      "selfhosted"
    ],
    "language": "en",
    "postedWithinDays": 1
  }'

# 2. An account's recent posts (start a run)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/runs?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "accounts": [
      "https://mastodon.social/@username"
    ],
    "maxResultsPerSource": 200
  }'

# 3. The newest posts on an instance (wait and get the dataset items in one call)
curl -sS -X POST "https://api.apify.com/v2/acts/${ACTOR}/run-sync-get-dataset-items?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "instanceTimeline": true,
    "instance": "fosstodon.org",
    "hashtags": []
  }'
