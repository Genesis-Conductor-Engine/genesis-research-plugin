---
name: search-research
description: Search Igor Holt's Genesis Conductor research packet (papers, shards, tests, drafts) by meaning and return cited chunks. Use when the user asks what the research says about a topic, wants prior work from the packet, or needs a source path, DOI, or status for an artifact.
---

# Search the research packet

## When to Use
- "What does the packet say about Landauer / eviction / OST / sear / DOA …"
- "Find the shard / test / draft about …"
- Any answer that should be grounded in the packet instead of memory.

## Workflow
1. Call the `genesis-research` MCP tool `search` with `{"query": "<question>", "k": 8}`. Narrow with `"folder"` when the user names a status: `01_in-work`, `02_near-completion`, `03_ready-for-publish`, `04_published`, `05_shards`, `06_drafts`, `07_tests`, `08_references`.
2. If results are empty, call `get_index` (the packet may still be indexing) and answer from INDEX.md, saying so.
3. For a full document, call `get_file` with the `path` from a result.
4. With the public demo key, only `search` exists: `k` is capped at 5, only `03_ready-for-publish`, `04_published` and `05_shards` are searchable, and `get_file`/`get_index` are unavailable. Cite the `path` and the DOI, and say a full key is needed for whole documents.
5. Answer with inline citations: `[path · folder]`, plus DOI or repo link when the result carries one.

## Evidence rules (always)
- Label each factual statement **FACT** (DOI minted, HTTP 200, code/tests exist) or **CLAIM** (asserted, not independently reproduced: performance, thermodynamic η values, revenue, DFT+U results).
- Never state that Igor holds an NSF or EU grant. NSF award 2530747 (CAIG) belongs to MIT/Ferrari.
- Never quote Delta Truth divergence/consensus numbers as measurements; no code computes them from data.
- If two sources disagree, report both and the paths; do not pick silently.

## Best Practices
- Keep `k` at 5–10; rerank by reading snippets, not by score alone.
- Quote at most a few lines per chunk; link the file instead of pasting it.
