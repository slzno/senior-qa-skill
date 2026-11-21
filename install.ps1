# Instalador del skill senior-qa para Windows (PowerShell)
# Uso:
#   .\install.ps1 claude            -> global en %USERPROFILE%\.claude\skills
#   .\install.ps1 claude-project    -> proyecto actual (.claude\skills)
#   .\install.ps1 cursor            -> proyecto actual (.cursor\rules)
#   .\install.ps1 all               -> claude global + cursor en el proyecto actual

param([string]$Target = "all")

$RepoRaw = if ($env:REPO_RAW) { $env:REPO_RAW } else { "https://raw.githubusercontent.com/TU_USUARIO/senior-qa-skill/main" }
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

function Get-RepoFile($Rel, $Dest) {
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $Dest) | Out-Null
    $Local = Join-Path $ScriptDir $Rel
    if (Test-Path $Local) { Copy-Item $Local $Dest -Force }
    else { Invoke-WebRequest -Uri "$RepoRaw/$Rel" -OutFile $Dest -UseBasicParsing }
    Write-Host "  ok -> $Dest"
}

function Install-ClaudeGlobal  { Write-Host "Claude Code (global):";  Get-RepoFile "skills/senior-qa/SKILL.md" "$HOME\.claude\skills\senior-qa\SKILL.md" }
function Install-ClaudeProject { Write-Host "Claude Code (proyecto):"; Get-RepoFile "skills/senior-qa/SKILL.md" "$PWD\.claude\skills\senior-qa\SKILL.md" }
function Install-Cursor        { Write-Host "Cursor (proyecto):";      Get-RepoFile "cursor/.cursor/rules/senior-qa.mdc" "$PWD\.cursor\rules\senior-qa.mdc" }

switch ($Target) {
    "claude"         { Install-ClaudeGlobal }
    "claude-project" { Install-ClaudeProject }
    "cursor"         { Install-Cursor }
    "all"            { Install-ClaudeGlobal; Install-Cursor }
    default          { Write-Host "Opcion no valida: $Target"; exit 1 }
}
Write-Host "Listo. Reinicia Claude Code o Cursor."
