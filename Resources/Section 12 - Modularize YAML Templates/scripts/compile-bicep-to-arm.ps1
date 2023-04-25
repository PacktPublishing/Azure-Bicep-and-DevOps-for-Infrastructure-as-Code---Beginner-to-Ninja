param(
    $filePath,
    $bicepTemplate,
    $outFile
)

try{
    Write-Host "Now compiling BICEP to ARM........................................."
    Write-Host "filePath: ${filePath}"
    Write-Host "bicepTemplate: ${bicepTemplate}"
    Write-Host "outFile: ${outFile}"
    Write-Host "..................................................................."
    az bicep upgrade
    az bicep build --file "${filePath}/${bicepTemplate}" --outfile "${filePath}/${outFile}" 
    $files=Get-ChildItem -Path ${filePath}
    Write-Host "Show Files........"
    Write-Host "${files}" 
}catch{
    $message = $_.Exception.Message
    $stackTraceText = $_.Exception.StackTrace
    Write-Host "The script failed with the following text"
    Write-Host $message
    Write-Host $stackTraceText
    throw "Script Halted"
}
