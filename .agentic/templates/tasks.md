---
spec: NNN-slug
artifact: tasks
status: planned      # planned | in-progress | done
date:
---

# Tasks: <title>

Each task: small enough to review in one sitting, independently testable, traced to an AC.
Tick boxes as you go; note deviations inline instead of silently changing scope.

| # | Task | Traces to | Status |
|---|---|---|---|
| T1 | | AC-1 | [ ] |
| T2 | | AC-2 | [ ] |

## Pre-implementation self-check
- [ ] Every AC is covered by at least one task.
- [ ] No task introduces behavior absent from requirements.md.
- [ ] requirements.md (and design.md when required) are approved.

## Verification
| AC | Test(s) | Result |
|---|---|---|
| AC-1 | | |

- [ ] Full test suite green
- [ ] Lint / type-check clean
- [ ] `bash scripts/check-agentic.sh` passes

## Deviations log
<!-- What changed vs. the plan and why. Feeds retro.md. -->
