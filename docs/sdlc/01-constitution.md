# Constitution

Non-negotiable principles. Agents load this before planning any change.
Changes require human approval (AGENTS.md §4) and should be rare.

## Project principles

<!-- BOOTSTRAP: 5–10 principles specific to this project, e.g.
1. **Correctness over speed** — money values use decimal types, never floats.
2. **Test-first for domain logic** — every AC has an automated test.
3. **Simplicity** — no new dependency without an ADR.
-->

## Agent principles (keep)

1. **Specs before code.** Non-trivial work starts from an approved `requirements.md`.
2. **Humans own decisions.** Agents propose; humans approve gates, scope and trade-offs.
3. **No silent gaps.** Unknowns are written down as `TBD(owner)` and asked, never guessed.
4. **Evidence over claims.** "Done" means tests run and passed, not "should work".
5. **Small, reversible steps.** One concern per commit/PR.
6. **The setup learns.** Corrections are recorded and promoted via `.agentic/EVOLVE.md`.
