# EVOLVE protocol

The template is a starting point, not a finished product. This protocol keeps the agent setup
(AGENTS.md, SDLC templates, constitution, commands) adapting to how this team actually works.
Run it continuously once `state.yml → phase: active`.

The loop: **observe → record → promote → prune.**

---

## 1. Observe (during every session)

Treat these as signals that the setup is wrong or incomplete:

- The human corrects you on something the docs did not tell you ("we always use X", "don't do Y").
- You had to discover a command, path or convention by trial and error.
- A gate was skipped, overruled, or felt like pure ceremony to the human.
- The same review comment appears on two or more PRs.
- A spec artifact section was left empty or unused across several specs.
- A rule in AGENTS.md contradicts what the code or the human actually does.

## 2. Record (immediately, low friction)

Append one line to `docs/memory/learnings.md`:

```
- YYYY-MM-DD | <signal type> | <what happened> | <proposed rule> | seen: 1
```

If a matching entry exists, increment `seen` instead of adding a duplicate.
Recording needs no approval. Never record secrets or personal data.

## 3. Promote (when a learning is proven)

A learning is ready to promote when **any** of these is true:

- `seen ≥ 2`, or
- the human stated it as a rule explicitly, or
- it fixes a factual error (wrong command, wrong path).

Where it goes:

| Kind of learning | Destination |
|---|---|
| Command, path, tool usage | `AGENTS.md §2` or §7 |
| Coding/style rule | `AGENTS.md §5` or §6 |
| Principle (quality, security, scope) | `docs/sdlc/01-constitution.md` |
| Workflow/gate change | `AGENTS.md §3` and the affected `.agentic/templates/*` |
| Domain term | `docs/sdlc/03-glossary.md` |
| Area-specific rule | a nested `AGENTS.md` in that directory |
| Repeated multi-step procedure | a new `.claude/commands/*.md` (and mention it in §7) |
| Significant decision | an ADR in `docs/adr/` |

Promotion rules:
- Factual fixes (wrong command/path): apply directly, commit as `chore(agentic): …`.
- Everything else: propose the diff to the human (AGENTS.md §4 "Ask first"), apply after approval.
- Mark the learning line `→ promoted to <file>` rather than deleting it.
- Log every applied change in `docs/memory/evolution-log.md` and bump `evolution.revisions`.

## 4. Review & prune (periodic)

Trigger a review when either threshold in `state.yml → evolution` is reached
(`review_every_specs` completed specs, or `review_every_days` since `last_review`),
or when the human asks. During a review:

1. Read all `retro.md` files since the last review; extract learnings.
2. Remove AGENTS.md rules that are obsolete, duplicated, or now enforced by tooling (lint/CI).
3. Keep AGENTS.md under ~150 lines — move detail to `docs/sdlc/` or nested AGENTS.md files.
4. Check rigor still fits: many skipped gates → suggest lowering; incidents/regressions → raising.
5. Compress `learnings.md`: archive promoted lines older than 90 days into a one-paragraph summary.
6. Run `bash scripts/check-agentic.sh`.
7. Update `last_review`, log the review, open one PR: `chore(agentic): periodic review`.

## 5. Pulling template updates (optional)

If `template.upstream` is set and the human asks to sync:

1. Fetch the upstream template and diff only `.agentic/`, `scripts/`, `.claude/commands/`.
2. Never overwrite `AGENTS.md`, `docs/`, or customized templates wholesale — merge by hand,
   keeping local customizations, and present the merge as a PR.
3. Bump `template.version`.

## Guardrails on self-modification

- Never weaken a "Never" rule or the constitution's agent principles without explicit human approval.
- Never remove a human approval gate on your own initiative; propose it with evidence.
- One concern per change, so each customization can be reviewed and reverted on its own.
