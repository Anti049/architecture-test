# Adds "resolution: workspace" to every child pubspec.yaml that lacks it.
# Run from a workspace root (either the repo root or ./isar-workspace).
Get-ChildItem -Path .\packages, .\apps -Recurse -Filter pubspec.yaml |
  Where-Object { $_.FullName -notmatch '\\build\\' } |
  ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    if ($content -notmatch '(?m)^resolution:\s*workspace') {
      Add-Content $_.FullName "`nresolution: workspace"
      Write-Host "Updated $($_.FullName)"
    }
  }
