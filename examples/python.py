"""Mastodon Scraper - Python example.

pip install apify-client
export APIFY_TOKEN=your_token
"""
import os

from apify_client import ApifyClient

client = ApifyClient(os.environ["APIFY_TOKEN"])

# Hashtag posts in English from the past day
run = client.actor("Turboextract/mastodon-posts-hashtags").call(run_input={
    "hashtags": [
        "opensource",
        "selfhosted"
    ],
    "language": "en",
    "postedWithinDays": 1
})

# Stream every item
for item in client.dataset(run["defaultDatasetId"]).iterate_items():
    print(item.get("createdAt"), item.get("favourites"), item.get("text"))

# Or fetch one page of items
page = client.dataset(run["defaultDatasetId"]).list_items(limit=100)
print(f"{page.total} items in dataset")
