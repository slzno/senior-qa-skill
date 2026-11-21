#!/usr/bin/env bash
# Instalador del skill senior-qa para Claude Code y Cursor
# Uso:
#   ./install.sh claude            -> instala global en ~/.claude/skills (todos tus proyectos)
#   ./install.sh claude-project    -> instala en el proyecto actual (.claude/skills)
#   ./install.sh cursor            -> instala la regla en el proyecto actual (.cursor/rules)
#   ./install.sh all               -> claude global + cursor en el proyecto actual
#
# Tambien sin clonar el repo (cambia TU_USUARIO):
#   curl -fsSL https://raw.githubusercontent.com/TU_USUARIO/senior-qa-skill/main/install.sh | bash -s -- all

set -euo pipefail

REPO_RAW="${REPO_RAW:-https://raw.githubusercontent.com/TU_USUARIO/senior-qa-skill/main}"
TARGET="${1:-all}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd || pwd)"

get_file() {
  # $1 = ruta relativa en el repo, $2 = destino
  mkdir -p "$(dirname "$2")"
  if [ -f "$SCRIPT_DIR/$1" ]; then
    cp "$SCRIPT_DIR/$1" "$2"
  else
    curl -fsSL "$REPO_RAW/$1" -o "$2"
  fi
  echo "  ok -> $2"
}

install_claude_global() {
  echo "Claude Code (global):"
  get_file "skills/senior-qa/SKILL.md" "$HOME/.claude/skills/senior-qa/SKILL.md"
}

install_claude_project() {
  echo "Claude Code (proyecto actual):"
  get_file "skills/senior-qa/SKILL.md" "$PWD/.claude/skills/senior-qa/SKILL.md"
}

install_cursor() {
  echo "Cursor (proyecto actual):"
  get_file "cursor/.cursor/rules/senior-qa.mdc" "$PWD/.cursor/rules/senior-qa.mdc"
}

case "$TARGET" in
  claude)         install_claude_global ;;
  claude-project) install_claude_project ;;
  cursor)         install_cursor ;;
  all)            install_claude_global; install_cursor ;;
  *) echo "Opcion no valida: $TARGET (usa claude | claude-project | cursor | all)"; exit 1 ;;
esac

echo "Listo. Reinicia Claude Code o Cursor para que tome el skill."
