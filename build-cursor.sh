#!/usr/bin/env bash
# Regenera la regla de Cursor a partir de skills/senior-qa/SKILL.md
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p cursor/.cursor/rules
{
cat <<'EOF'
---
description: Senior QA multi-stack (Android, Laravel, Drupal, React, Next.js, Tailwind, React Native). Usar cuando se pida revisar, probar o validar una mejora, un PR o un cambio.
globs:
alwaysApply: false
---
EOF
awk 'BEGIN{n=0} /^---$/ && n<2 {n++; next} n>=2' skills/senior-qa/SKILL.md
} > cursor/.cursor/rules/senior-qa.mdc
echo "ok -> cursor/.cursor/rules/senior-qa.mdc"
