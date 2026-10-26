#!/usr/bin/env bash
# Validates the agentic SDLC setup. Run locally and in CI.
# Before bootstrap: checks structure only. After bootstrap (phase: active): also checks that
# no BOOTSTRAP placeholders remain and that AGENTS.md stays lean.
set -euo pipefail
cd "$(git rev-parse --show-toplevel 2>/dev/null || echo "$(dirname "$0")/..")"

fail=0
err()  { echo "✗ $*"; fail=1; }
ok()   { echo "✓ $*"; }
warn() { echo "! $*"; }

required=(
  AGENTS.md CLAUDE.md
  .agentic/state.yml .agentic/BOOTSTRAP.md .agentic/EVOLVE.md
  .agentic/templates/requirements.md .agentic/templates/design.md
  .agentic/templates/tasks.md .agentic/templates/retro.md .agentic/templates/adr.md
  docs/sdlc/00-vision.md docs/sdlc/01-constitution.md
  docs/sdlc/02-architecture.md docs/sdlc/03-glossary.md
  docs/memory/learnings.md docs/memory/evolution-log.md
)
for f in "${required[@]}"; do [[ -f "$f" ]] || err "missing $f"; done
[[ $fail -eq 0 ]] && ok "required files present"

grep -q '^@AGENTS.md' CLAUDE.md || err "CLAUDE.md must import @AGENTS.md"

phase=$(sed -n 's/^phase:[[:space:]]*\([a-z]*\).*/\1/p' .agentic/state.yml)
[[ -n "$phase" ]] || err "state.yml has no phase"
echo "  phase: ${phase:-?}"

if [[ "$phase" == "active" ]]; then
  # Placeholders must be gone from project files (templates and protocol docs excluded).
  hits=$(grep -rln 'BOOTSTRAP' AGENTS.md docs/sdlc README.md 2>/dev/null || true)
  if [[ -n "$hits" ]]; then err "BOOTSTRAP placeholders remain in: $hits"; else ok "no placeholders left"; fi

  for key in name type origin rigor; do
    grep -Eq "^[[:space:]]+$key:[[:space:]]+null" .agentic/state.yml && err "state.yml: $key is null"
  done
  grep -q '^bootstrapped_at: null' .agentic/state.yml && err "state.yml: bootstrapped_at is null"

  lines=$(wc -l < AGENTS.md)
  (( lines > 200 )) && err "AGENTS.md is $lines lines (limit 200) — prune via EVOLVE §4"
  (( lines > 150 )) && warn "AGENTS.md is $lines lines — consider pruning"
else
  warn "repo not bootstrapped yet — ask your agent to follow .agentic/BOOTSTRAP.md"
fi

# Basic secret hygiene for files an agent might create.
if git ls-files 2>/dev/null | grep -Eq '(^|/)\.env($|\.)' ; then
  git ls-files | grep -E '(^|/)\.env($|\.)' | grep -vq '\.example$' && err ".env file is tracked"
fi

[[ $fail -eq 0 ]] && ok "agentic check passed" || { echo "agentic check failed"; exit 1; }
