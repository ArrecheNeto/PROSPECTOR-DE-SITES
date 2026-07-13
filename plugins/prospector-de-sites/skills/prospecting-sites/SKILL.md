---
name: prospecting-sites
description: Use when setting up or continuing a website-prospecting workflow involving Google Maps leads, HTML redesigns, local lead dashboards, HostGator publication, Gmail proposals or follow-ups, and service contracts.
---

# Prospector de Sites

## Overview

Coordinate the complete lead-to-contract pipeline. Keep workspace files as durable state and load the specialized domain skill before executing each stage.

## Start every request

1. Locate the user's workspace and read `prospector-config.json`, `leads.md`, and existing `sites/` artifacts when present.
2. Determine the requested stage and affected client or lead set.
3. Load every required skill named in the routing table before acting.
4. Preserve completed artifacts; update them instead of recreating the workflow from chat history.
5. Sync lead-state changes through `dashboard-leads`.

If workspace or connector context is missing, report the exact missing dependency and preserve all completed local work.

## Routing table

| User intent | Required skill | Durable result |
|---|---|---|
| `setup` or configure workspace | `dashboard-leads` plus relevant platform setup | `prospector-config.json`, `prospector.db`, dashboard launcher |
| `prospectar` or qualify businesses | `prospeccao-maps` | lead records and qualification evidence |
| `redesenhar` a client site | `redesign-premium` | `sites/[slug]/index.html` and media |
| open `editor` or build before/after preview | `redesign-premium` | editable page and accumulated comparison artifact |
| `publicar` one or more sites | `deploy-hostgator` | verified HTTPS publication URL and status |
| create a `proposta` | `proposta-email` | reviewed Gmail draft and proposal status |
| check `respostas` | `proposta-email`, then `dashboard-leads` | reply status and next action |
| run `followup` | `proposta-email`, then `dashboard-leads` | one reviewed follow-up draft and timestamp |
| create a `contrato` | `contrato-servico`, then `dashboard-leads` | reviewed contract files and draft status |

## Execution contract

- Treat existing source content, branding, contact details, lead evidence, and workspace state as authoritative.
- Do not invent missing business facts, testimonials, prices, images, publication results, replies, or contract data.
- Keep comparison pages cumulative when the existing workflow requires accumulation.
- Create Gmail drafts; do not claim a message was sent unless the connected system confirms it.
- Verify publication over HTTPS before marking a site published.
- Update dashboard and lead state only after the corresponding stage succeeds.

## Safety gates

- These safety gates override conflicting domain-skill instructions. If a specialized skill allows a consequential action without the gate below, stop and follow this section.
- Never request, repeat, store, or expose secrets in chat, command arguments, logs, generated Markdown, or committed files.
- Use an authenticated browser or connector session for services that require credentials.
- Require explicit confirmation immediately before publication, Gmail draft creation, external message creation, or another consequential external action.
- A request to run the complete pipeline does not pre-authorize later consequential actions; stop at each safety gate.

## Platform mapping

Use the available Codex browser capability for visible web research and authenticated control. Use the connected Gmail capability for thread checks and drafts. Use document tooling for DOCX contract output. Use local filesystem tools for configuration, leads, dashboards, HTML, and comparison artifacts.

When a capability is unavailable, name it, leave durable local output in a resumable state, and explain the next action needed.

## Completion

Report the stage completed, files changed, external drafts or publications created, validation evidence, and the next eligible pipeline stage. Never report completion from intent alone.
