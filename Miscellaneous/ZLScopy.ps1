function CopyPrep
{
    param($subfolder)
    $stem = Split-Path "$($_.source)" -NoQualifier
    $src = Join-Path "$($_.source)" -ChildPath $subfolder
    $destin = Join-Path "./" -ChildPath $stem | Join-Path -ChildPath $subfolder
    Join-Path $stem "import.rawdata" | Write-Output
    # Copy files
    robocopy $src $destin /E /NFL /NP /MT:20
    # Copy import.rawdata
    $import_rawdata_destin = Join-Path "./" -ChildPath $stem
    robocopy "$($_.source)" $import_rawdata_destin "import.rawdata" | Out-Null
}

Import-Csv .\copy.csv | ForEach-Object {
    CopyPrep -subfolder "Image"
    CopyPrep -subfolder "PET"
}