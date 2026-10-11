---
name: publish-pipeline
description: Run the Genesis Conductor research pipeline (reindex, OpenSearch bulk, Hugging Face staging, outreach drafts) in staged, human-gated mode. Use when the user asks to refresh the research index, stage papers for Hugging Face, or prepare outreach for newly published items. Never publishes or sends.
---

# Publish pipeline (gated)

## When to Use
- "Refresh / reindex the research packet."
- "Stage the ready-for-publish items for Hugging Face."
- "Draft outreach for what was just published."

## Workflow
1. Run `scripts/publish-pipeline.sh --dry-run` from this plugin. It wraps `run_pipeline.sh` in `$RESEARCH_WORKFLOWS_DIR` (default `/workspace/research-workflows`).
2. Show the user the step summary: folder counts, chunk counts, HF staging folders, outreach drafts.
3. Only if the user asks for the live run, run `scripts/publish-pipeline.sh --live`. That embeds and uploads to the retrieval index and bulk-loads OpenSearch when `OPENSEARCH_URL` is set. It still never publishes to the Hub and never sends a message.
4. List every remaining public action as a separate YES gate (one HF repo per gate, one message per gate).

## Hard gates
- No Hugging Face `create_repo` / upload, no X post or DM, no email, no Product Hunt / HN / marketplace submission without the user's explicit YES for that single action.
- DMs are signed `~sent with G` when the user has asked for that signature.
- Never print or paste the retrieval key, HF token, or any secret.
