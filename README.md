# Genesis Research (Cursor plugin)

Search, cite and stage publication of the Genesis Conductor research packet from inside your agent. The plugin talks to the Genesis retrieval service at `https://retrieval.genesisconductor.io/mcp` (Cloudflare Worker, EmbeddingGemma-300m embeddings, R2 vector store).

## What's inside
| Component | Path | Purpose |
|---|---|---|
| MCP server | `mcp.json` | `genesis-research` → `search`, `get_file`, `get_index` over streamable HTTP, bearer key from `RESEARCH_RETRIEVAL_KEY` |
| Skill | `skills/search-research` | Semantic search with FACT/CLAIM-labelled citations |
| Skill | `skills/cite-with-peers` | Related-work and BibTeX from `08_references` (verified peer works only) |
| Skill | `skills/publish-pipeline` | Gated wrapper over `run_pipeline.sh`: reindex, OpenSearch bulk, HF staging, outreach drafts |
| Rule | `rules/evidence-labels.mdc` | FACT/CLAIM labelling; blocks known false attributions |
| Command | `commands/research-search.md` | `/genesis-research:research-search <query>` |
| Script | `scripts/publish-pipeline.sh` | `--dry-run` (default) or `--live`; never publishes or sends |

## Install
1. Clone https://github.com/Genesis-Conductor-Engine/genesis-research-plugin into `~/.cursor/plugins/local/genesis-research/` (or install from the marketplace once listed).
2. Export a key in the environment Cursor starts from. Anyone can use the **public demo key**:
   ```bash
   export RESEARCH_RETRIEVAL_KEY="gcr_demo_JkV2p3lOLelFGxyGtN0WN0VxRG_0SX-w"
   ```
   The demo key is meant to be public. Its limits are listed under "Demo key limits" below. For full access (all tools and folders), ask the maintainer for a key, and never commit a non-demo key.
3. Restart Cursor, open **Settings → Tools & MCP**, and confirm `genesis-research` is connected. A demo key shows 1 tool (`search`); a full key shows 3.
4. Optional, for the pipeline skill: `export RESEARCH_WORKFLOWS_DIR=/path/to/research-workflows`.

## Use
- "Search the research packet for dissonance-weighted eviction."
- `/genesis-research:research-search Landauer context energy basis`
- "Draft related work for the OST packet using peers."
- "Dry-run the publish pipeline."

## Endpoints (for non-MCP clients)
`GET /health` (no auth) · `POST /search {"query","k","folder"}` · `GET /file?path=` · `GET /index` · `POST /mcp`. All but `/health` need `Authorization: Bearer $RESEARCH_RETRIEVAL_KEY`. The demo key can call only `POST /search` and `search` over MCP.

```bash
curl -s https://retrieval.genesisconductor.io/search \
  -H "Authorization: Bearer $RESEARCH_RETRIEVAL_KEY" -H 'content-type: application/json' \
  -d '{"query":"perturbation invariance","k":5}'
```

## Demo key limits
- Searches cover `04_published`, `03_ready-for-publish` and `05_shards` only. Other folders return 403.
- `k` is capped at 5. `/file`, `/index` and `/admin` return 403, and over MCP only `search` is listed.
- Rate limits: 30 requests per minute per IP and 1,000 requests per day across all demo users. Over the limit you get HTTP 429 with `retry-after: 60`.
- Live page: https://genesisconductor.io/research

## Safety model
- Read-only MCP tools. The pipeline script never writes to the Hugging Face Hub and never sends a message; every public action is a separate human YES.
- The chunker skips `.env`, key files and token-shaped strings before anything is embedded.

## Status
- Index: the first full embed is still running. `/health` reports live counts, and searches can return empty results until it finishes.
- Public demo key available (search only, rate-limited). Full access is key-gated.

## License
MIT © 2026 Igor A. Holt
