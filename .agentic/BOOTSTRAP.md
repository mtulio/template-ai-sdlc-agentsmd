# BOOTSTRAP protocol

Run this **once**, right after the template is cloned (`state.yml → phase: unbootstrapped`).
Goal: turn the generic template into this project's own operating setup, using the Agentic SDLC
files as the scaffold. Work in order; do not skip steps. Commit at the end of each step.

Set `phase: bootstrapping` in `.agentic/state.yml` before Step 1 so an interrupted session can resume.
If you resume, find the first step whose checkbox in `docs/memory/evolution-log.md` is unchecked.

---

## Step 1 — Detect

Without asking anything yet, inspect the repository:

- Is there source code beyond this template? → `origin: brownfield`, else `greenfield`.
- Package manifests (`package.json`, `pyproject.toml`, `go.mod`, `Cargo.toml`, `pom.xml`, …),
  lockfiles, Dockerfiles, CI configs, existing READMEs, existing tests.
- For brownfield repos: infer language versions, build/test/lint commands, directory layout,
  and naming/style conventions from the actual code (sample at least 5 representative files).
- `git remote -v` and `git log` for the project name and upstream template URL.

Write a short findings list into `docs/memory/evolution-log.md` under the bootstrap entry.

## Step 2 — Interview (one round)

Ask the human **one batch** of questions — only what you could not detect. Offer your best guess
as the default for each so they can just confirm. Cover:

1. Project name and one-sentence purpose.
2. Who it serves, and what "success" looks like in 3–6 months.
3. Project type and stack (confirm detected values).
4. Rigor level: `lite`, `standard` or `strict` (recommend one with a one-line reason).
5. Spec model: `living` or `flow-forward` (default `living`).
6. Owners who approve gates (GitHub handles).
7. Hard constraints: compliance, data sensitivity, performance budgets, hosting, budget.
8. Anything agents must never touch.

If the human is not available (unattended run), use your best guesses, mark each as
`TBD(owner): <guess>` in the files, and list them at the top of your final report.

## Step 3 — Fill the project truth (`docs/sdlc/`)

Create these from your findings + answers. Replace every placeholder; never leave the template
prose behind.

- `00-vision.md` — problem, users, goals, non-goals, success metrics.
- `01-constitution.md` — 5–10 non-negotiable principles (quality, security, testing, simplicity).
  Keep the template's "Agent principles" section; add project principles above it.
- `02-architecture.md` — for greenfield: initial intended shape (C4 context + containers in
  Mermaid). For brownfield: the architecture **as it is today**, derived from the code.
- `03-glossary.md` — domain terms you encountered or were told about.

## Step 4 — Customize `AGENTS.md`

- Fill every `<!-- BOOTSTRAP ... -->` marker (overview, commands, boundaries, conventions), then
  delete the marker comment.
- Commands must be ones you have **actually run successfully**. If you could not run one, write it
  with a `# unverified` suffix.
- Keep it short: the file should stay under ~150 lines. Push detail into `docs/sdlc/`.
- Do not remove §0, §3, §4 "Never" items, §6 or §7 — those are the template's spine.
- If the repo has clearly separate parts (e.g. `apps/api`, `apps/web`), create a nested
  `AGENTS.md` in each containing only what differs from the root.

## Step 5 — Tailor the SDLC templates

Edit `.agentic/templates/` to fit the chosen rigor and stack:

- `lite`: trim `requirements.md` and `design.md` to their "Lite" sections.
- `strict`: keep the traceability tables; add stack-specific checklists to `tasks.md`
  (e.g. migration review, accessibility check, threat model).
- Add any artifact type the human mentioned (e.g. `runbook.md`, `threat-model.md`).

## Step 6 — Seed the first spec

Create `docs/specs/001-<slug>/` from the templates:

- Greenfield: the first meaningful slice of the product (walking skeleton).
- Brownfield: "Adopt agentic SDLC" — documents current behavior of the most-changed area
  (`git log --format= --name-only | sort | uniq -c | sort -rn | head`).

Fill `requirements.md` only (the human approves it before design). Set `next_spec_number: 2`.

## Step 7 — Wire the guardrails

- Update `.github/workflows/agentic-check.yml` with the real lint/test commands from AGENTS.md §2
  (keep the agentic check step).
- Adjust `.github/pull_request_template.md` to the chosen rigor.
- Create `docs/adr/0001-adopt-agentic-sdlc.md` recording: template version, rigor, spec model,
  and why.

## Step 8 — Close out

1. Run `bash scripts/check-agentic.sh`; fix everything it reports.
2. Update `.agentic/state.yml`: all `project.*` and `sdlc.*` fields, `phase: active`,
   `bootstrapped_at: <today>`, `evolution.revisions: 1`, `evolution.last_review: <today>`.
3. Replace `README.md`'s template section with a real project README (keep a short
   "Working with agents" section that points to `AGENTS.md`).
4. Log the bootstrap in `docs/memory/evolution-log.md` with all steps checked.
5. Commit as `chore(agentic): bootstrap from agentic-sdlc-template v<version>` and open a PR.
6. Report to the human: what you filled, what is `TBD`, and the first spec waiting for approval.

After this, `BOOTSTRAP.md` is never run again. `EVOLVE.md` takes over.
