Function Copy-Map{
    param (
    [string] $mapToCopy = "/tmp/minimap-with-grid-overlay-and-poi-markers"
)

$username=$(Get-ChildItem Env:\USERNAME).value
$PathTibiaMap = "/home/$username/.local/share/CipSoft GmbH/Tibia/packages/Tibia/minimap"

$zipFile = $mapToCopy + ".zip" 

try {
    Expand-Archive -Path $zipFile -DestinationPath $mapToCopy -Force    
}
catch [System.Management.Automation.ItemNotFoundException] {
    $url = "https://tibiamaps.github.io/tibia-map-data/minimap-with-grid-overlay-and-poi-markers.zip"
    Invoke-WebRequest -Uri $url -OutFile $zipFile
    Expand-Archive -Path $zipFile -DestinationPath $mapToCopy -Force
}


$minimapFolder = $mapToCopy + "/minimap/*"
Write-Output "Copiando Mapas para $PathTibiaMap"

Copy-Item $minimapFolder -Destination $PathTibiaMap -Recurse -Force

}

Copy-Map