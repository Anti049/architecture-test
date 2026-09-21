# bootstrap.ps1 - one-shot setup for the architecture-test monorepo on Windows 11.
# Run from the repo root:  powershell -ExecutionPolicy Bypass -File .\bootstrap.ps1

$ErrorActionPreference = 'Stop'

function Section($msg) { Write-Host "`n=== $msg ===" -ForegroundColor Cyan }

Section 'Verifying toolchain'
flutter --version
dart pub global activate melos

Section 'Ensuring workspace resolution on all child packages'
if (Test-Path .\tools\set_workspace_resolution.ps1) {
  & .\tools\set_workspace_resolution.ps1
}
Push-Location .\isar-workspace
if (Test-Path ..\tools\set_workspace_resolution.ps1) {
  & ..\tools\set_workspace_resolution.ps1
}
Pop-Location

Section 'Bootstrapping MAIN workspace'
melos bootstrap

Section 'Codegen (MAIN): freezed / dart_mappable / drift'
melos run gen

Section 'Bootstrapping ISAR workspace (isolated, build_runner 2.4.x)'
Push-Location .\isar-workspace
melos bootstrap

Section 'Codegen (ISAR): isar_community_generator'
melos run gen
Pop-Location

Section 'Analyzing MAIN workspace'
melos run analyze

Write-Host "`nDone. Run an app with:" -ForegroundColor Green
Write-Host '  cd apps\app_baseline; flutter run -d windows'
Write-Host '  cd isar-workspace\apps\app_isar; flutter run -d windows'
