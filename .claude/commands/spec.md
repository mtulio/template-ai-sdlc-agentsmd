---
description: Start or advance a spec through the SDLC phases defined in AGENTS.md §3.
argument-hint: <new feature description | existing NNN-slug>
---

1. Read `.agentic/state.yml` (rigor, spec model, next number) and `docs/sdlc/01-constitution.md`.
2. If `$ARGUMENTS` names an existing `docs/specs/NNN-*` folder, find its earliest artifact that is
   not `approved`/`done` and work on that phase only.
3. Otherwise create `docs/specs/<next_spec_number>-<slug>/` from `.agentic/templates/`, increment
   `next_spec_number`, and draft `requirements.md`.
4. Stop at every human gate in AGENTS.md §3 and ask for approval; list open `TBD` items.
5. When a spec finishes, draft `retro.md` and record learnings per `.agentic/EVOLVE.md`.

Request: $ARGUMENTS
