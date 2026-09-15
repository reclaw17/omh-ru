# Install the Russian OMH trigger pack into $env:OMH_HOME.
# Safe to re-run. Does not touch the oh-my-hermes install itself.
$ErrorActionPreference = "Stop"

$Owner = "reclaw17"
$Repo = "omh-ru"
$Branch = "main"
$RawUrl = "https://raw.githubusercontent.com/$Owner/$Repo/$Branch/ru.json"

$OmhHome = if ($env:OMH_HOME) { $env:OMH_HOME } else { Join-Path $HOME ".omh" }
$DestDir = Join-Path $OmhHome "routing\trigger-packs"
$Dest = Join-Path $DestDir "ru.json"

New-Item -ItemType Directory -Force -Path $DestDir | Out-Null

$localJson = Join-Path $PSScriptRoot "ru.json"
if (Test-Path $localJson) {
    Copy-Item -Force $localJson $Dest
} else {
    Invoke-WebRequest -UseBasicParsing -Uri $RawUrl -OutFile $Dest
}

Get-Content -Raw -Encoding UTF8 $Dest | ConvertFrom-Json | Out-Null

Write-Host "installed $Dest"
Write-Host "OMH_HOME=$OmhHome"

if (Get-Command omh -ErrorAction SilentlyContinue) {
    Write-Host ""
    Write-Host "omh doctor (packs):"
    omh doctor
    Write-Host ""
    Write-Host "smoke: omh recommend «сделай ревью кода»"
    omh recommend "сделай ревью кода" --limit 1
} else {
    Write-Host "omh not on PATH — pack is in place; run omh doctor after OMH is installed"
}

Write-Host ""
Write-Host "route-hint for this pack needs oh-my-hermes newer than 2.0.3 (fix #1535 / PR #1539)."
Write-Host "restart any running Hermes session so the plugin reloads."
