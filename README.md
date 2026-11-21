# senior-qa-skill

Skill de **Senior QA multi-stack** (Android, Laravel, Drupal, React, Next.js, Tailwind, React Native) para Claude y Cursor. Revisa el diff de cada mejora, corre y escribe pruebas, y entrega un reporte con veredicto (APROBADO / APROBADO CON OBSERVACIONES / RECHAZADO) y bugs con severidad.

## Estructura

```
senior-qa-skill/
├── .claude-plugin/
│   ├── plugin.json          # para instalar como plugin en Claude Code
│   └── marketplace.json
├── skills/senior-qa/SKILL.md            # el skill (Claude.ai y Claude Code)
├── cursor/.cursor/rules/senior-qa.mdc   # la misma guia como regla de Cursor
├── install.sh                # instalador Mac / Linux / Git Bash
├── install.ps1               # instalador Windows
└── README.md
```

## Instalacion rapida (npx skills)

Funciona con Claude Code, Cursor, Codex, OpenCode y otros agentes:

```bash
# global (todos tus proyectos)
npx skills add slzno/senior-qa-skill -g

# solo en el proyecto actual
npx skills add slzno/senior-qa-skill

# elegir agentes sin preguntas
npx skills add slzno/senior-qa-skill -g -a claude-code -a cursor -y
```

Actualizar despues de un push: vuelve a correr el mismo comando (usa `npx skills@latest` si tienes una version vieja del CLI en cache).

## 2. Instalar en Claude Code

**Opcion A - como plugin (recomendada, se actualiza desde GitHub):**

Dentro de Claude Code:
```
/plugin marketplace add slzno/senior-qa-skill
/plugin install senior-qa@senior-qa-marketplace
```

**Opcion B - con el script:**
```bash
# global, disponible en todos tus proyectos
curl -fsSL https://raw.githubusercontent.com/slzno/senior-qa-skill/main/install.sh | bash -s -- claude

# o solo en un proyecto (se puede commitear para todo el equipo)
curl -fsSL https://raw.githubusercontent.com/slzno/senior-qa-skill/main/install.sh | bash -s -- claude-project
```

**Opcion C - manual:** copia `skills/senior-qa/` a `~/.claude/skills/senior-qa/` (global) o a `.claude/skills/senior-qa/` dentro del proyecto.

Uso: "revisa esta mejora como QA", "prueba el cambio del login" o directamente `/senior-qa`.

## 3. Instalar en Cursor

Desde la raiz del proyecto donde lo quieres usar:

```bash
curl -fsSL https://raw.githubusercontent.com/slzno/senior-qa-skill/main/install.sh | bash -s -- cursor
```

Windows (PowerShell), con el repo clonado:
```powershell
.\install.ps1 cursor
```

Esto crea `.cursor/rules/senior-qa.mdc`. La regla esta en modo "Agent Requested" (`alwaysApply: false`): Cursor la carga sola cuando pides revisar o probar algo, o la invocas a mano con `@senior-qa` en el chat.

## 4. Instalar en Claude.ai (web / desktop)

Comprime la carpeta `skills/senior-qa` en un zip (el zip debe contener la carpeta `senior-qa/` con su `SKILL.md`) y subelo en la seccion de Skills de la configuracion de Claude.

```bash
cd skills && zip -r ../senior-qa.zip senior-qa && cd ..
```

## Actualizar

Edita `skills/senior-qa/SKILL.md` y regenera la regla de Cursor:

```bash
./build-cursor.sh
git commit -am "Actualiza senior-qa" && git push
```

Luego en Claude Code: `/plugin marketplace update senior-qa-marketplace`.
