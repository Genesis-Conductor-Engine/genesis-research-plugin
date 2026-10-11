#!/usr/bin/env bash
# Gated wrapper for the Genesis Conductor research pipeline.
#   --dry-run (default): local and staging steps only. No embeddings, uploads, Hub writes or messages.
#   --live: also embeds/uploads to the retrieval index and bulk-loads OpenSearch (if OPENSEARCH_URL is set).
# Neither mode publishes to Hugging Face or sends any message; those stay YES-gated.
set -euo pipefail
DIR="${RESEARCH_WORKFLOWS_DIR:-/workspace/research-workflows}"
[ -x "$DIR/run_pipeline.sh" ] || { echo "run_pipeline.sh not found in $DIR (set RESEARCH_WORKFLOWS_DIR)"; exit 2; }
case "${1:---dry-run}" in
  --dry-run) exec "$DIR/run_pipeline.sh" --dry-run ;;
  --live) echo "LIVE: embedding + index upload. Hub publish and messaging remain gated."; exec "$DIR/run_pipeline.sh" ;;
  *) echo "usage: $0 [--dry-run|--live]"; exit 64 ;;
esac
