# AGENTS.md

> Operating contract for any AI coding agent working in this repository
> (Claude Code, Codex, Copilot, Cursor, Gemini CLI, etc.).
> Humans: see `README.md`. Agents: read this file fully before acting.

---

## 0. First action, every session

1. Read `.agentic/state.yml`.
2. If `phase` is `unbootstrapped` or `bootstrapping`, **stop all other work** and follow
   `.agentic/BOOTSTRAP.md` until it finishes. Do not implement features in an unbootstrapped repo.
3. If `phase` is `active`, continue with this file, then load `docs/sdlc/01-constitution.md`
   and `docs/memory/learnings.md` before planning any change.
4. Throughout the session, follow `.agentic/EVOLVE.md`: this repo is meant to keep
   customizing itself as you learn how the team works.

---

## 1. Project overview

<!-- BOOTSTRAP: one paragraph — what this project is, who it serves, and why it exists. -->

- **Type:** <!-- BOOTSTRAP: api | library | cli | web-app | service | monorepo | other -->
- **Primary language / framework:** <!-- BOOTSTRAP: with versions -->
- **Vision & scope:** `docs/sdlc/00-vision.md`
- **Architecture:** `docs/sdlc/02-architecture.md`
- **Glossary:** `docs/sdlc/03-glossary.md`

## 2. Commands

Only list commands that are non-obvious or that differ from the stack's defaults.

| Purpose | Command |
|---|---|
| Install | <!-- BOOTSTRAP --> |
| Run locally | <!-- BOOTSTRAP --> |
| Test (fast, single file) | <!-- BOOTSTRAP --> |
| Test (full) | <!-- BOOTSTRAP --> |
| Lint / format | <!-- BOOTSTRAP --> |
| Type-check | <!-- BOOTSTRAP --> |
| Agentic repo check | `bash scripts/check-agentic.sh` |

Prefer the fast, scoped commands while iterating; run the full suite before declaring a task done.

## 3. SDLC workflow

Every non-trivial change flows through these phases. Each phase produces a Markdown artifact in
`docs/specs/NNN-short-slug/`, created from `.agentic/templates/`.

| # | Phase | Artifact | Gate (who approves) |
|---|---|---|---|
| 1 | Idea | `idea.md` | Optional |
| 2 | Requirements | `requirements.md` (EARS acceptance criteria) | **Human** |
| 3 | Design | `design.md` (+ ADR if a decision is hard to reverse) | **Human** (rigor ≥ standard) |
| 4 | Tasks | `tasks.md` (small, reviewable, traced to requirements) | Agent self-check |
| 5 | Implement | code + tests, ticking `tasks.md` | Tests green |
| 6 | Verify | verification section of `tasks.md` | Agent + CI |
| 7 | Review | PR using `.github/pull_request_template.md` | **Human** |
| 8 | Retro | `retro.md` → feeds `.agentic/EVOLVE.md` | Agent drafts, human skims |

**Rigor level** is set in `.agentic/state.yml` (`sdlc.rigor`):

- `lite` — phases 2, 4, 5, 7 only; requirements may be a short bullet list. Good for prototypes.
- `standard` — all phases except Idea; ADRs for significant decisions.
- `strict` — all phases, every requirement traced to a test, ADRs mandatory, design review required.

**What counts as trivial** (skip the spec, go straight to a PR): typo fixes, dependency bumps with
no API change, formatting, comment/doc-only edits, and single-line bug fixes with an obvious cause.

**Spec model** (`sdlc.spec_model`): `living` means you update the existing spec when behavior
changes; `flow-forward` means finished spec folders are frozen and changes get a new folder.

When requirements, design and tasks disagree, stop and reconcile them before writing more code.

## 4. Boundaries

**Always**
- Read the relevant spec folder before touching code it covers.
- Write or update tests alongside behavior changes.
- Keep commits small and use Conventional Commits (`feat:`, `fix:`, `docs:`, `chore(agentic):` …).
- Record hard-to-reverse decisions as ADRs in `docs/adr/`.

**Ask first**
- Adding a runtime dependency or a new external service.
- Changing public APIs, database schemas, CI/CD, or auth/security code.
- Editing `AGENTS.md`, `docs/sdlc/01-constitution.md`, or anything in `.agentic/` (propose a diff).
- Deleting files you did not create in this session.

**Never**
- Commit secrets, credentials, or `.env` files.
- Disable, skip, or weaken tests or CI checks to make something pass.
- Invent requirements. Unknowns become `TBD(owner)` and a question to the human.
- Push directly to the default branch.

<!-- BOOTSTRAP: add project-specific boundaries (e.g. regulated data, performance budgets). -->

## 5. Code conventions

Only rules that differ from the language's community defaults belong here.

<!-- BOOTSTRAP: conventions inferred from existing code or chosen by the human. -->

## 6. Learned conventions

Rules discovered while working with this team. Maintained via `.agentic/EVOLVE.md`.
Each line: the rule, then `(source, date)`.

<!-- EVOLVE: append promoted learnings here. Keep each entry to one line. -->

## 7. File map

| Path | Purpose |
|---|---|
| `.agentic/state.yml` | Machine-readable lifecycle state of this repo's agent setup |
| `.agentic/BOOTSTRAP.md` | One-time protocol run right after the template is cloned |
| `.agentic/EVOLVE.md` | Ongoing protocol for customizing this setup over time |
| `.agentic/templates/` | Blank SDLC artifacts (idea, requirements, design, tasks, adr, retro) |
| `docs/sdlc/` | Project-level truth: vision, constitution, architecture, glossary |
| `docs/specs/` | One folder per feature/change, holding its SDLC artifacts |
| `docs/adr/` | Architecture Decision Records |
| `docs/memory/` | Agent learnings and the evolution log |
| `.claude/commands/` | Optional Claude Code slash commands wrapping these protocols |
| `scripts/check-agentic.sh` | Validates the agentic setup (also run in CI) |

Subdirectories may contain their own `AGENTS.md`; the closest one to the file being edited wins,
and it only needs to state what differs from this root file.
