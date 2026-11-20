// Mastodon Scraper - Node.js example
// npm install apify-client
// APIFY_TOKEN=your_token node node.mjs
import { ApifyClient } from 'apify-client';

const client = new ApifyClient({ token: process.env.APIFY_TOKEN });

// An account's recent posts
const run = await client.actor('Turboextract/mastodon-posts-hashtags').call({
    "accounts": [
        "https://mastodon.social/@username"
    ],
    "maxResultsPerSource": 200
});

const { items } = await client.dataset(run.defaultDatasetId).listItems();
for (const item of items) {
    console.log(item.createdAt, item.favourites, item.text);
}
