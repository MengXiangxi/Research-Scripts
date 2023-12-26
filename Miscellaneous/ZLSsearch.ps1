$list = Get-ChildItem -Path F:\*FPSMA* -Recurse -Directory -Force -ErrorAction SilentlyContinue | Select-Object FullName
$list | Export-Csv -Path .\listF.csv -NoTypeInformation
