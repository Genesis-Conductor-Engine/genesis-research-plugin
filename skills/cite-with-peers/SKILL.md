---
name: cite-with-peers
description: Build a references section or related-work paragraph for a Genesis Conductor artifact using verified peer works from the packet's 08_references (affinity registry, PEERS.md, CITATION_MAP.md, REFERENCES.bib). Use when drafting a paper, README, post, or DM that should cite peers or Igor's own DOIs.
---

# Cite with peers

## When to Use
- Writing related work, a bibliography, or acknowledgements for a packet artifact.
- Tailoring outreach to a peer whose published work genuinely relates to the artifact.

## Workflow
1. Fetch `08_references/CITATION_MAP.md` and `08_references/REFERENCES.bib` with the MCP tool `get_file`. If `08_references` is not in the index yet, stop and say so; do not invent references.
2. Find the artifact row(s) in CITATION_MAP.md. Use only the listed bib keys.
3. For each candidate, open `08_references/PEERS.md` and confirm the peer row shows a **verified work** with a link. Rows marked "none verified" cannot be cited.
4. Check relevance by reading the cited work's title/abstract via the link; drop anything that only shares a keyword.
5. Emit BibTeX entries copied verbatim from REFERENCES.bib and a short "why" per citation.

## Rules
- CITATION_MAP entries are suggestions, not endorsements. Never write that a peer reviewed, endorsed, partnered with, or co-authored anything.
- Peer works are related-work context, never evidence for Igor's metrics (those stay CLAIM).
- No co-authors exist on Igor's Zenodo records; do not add any.
- Self-citations: only the DOIs present in REFERENCES.bib.
