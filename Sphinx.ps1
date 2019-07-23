[CmdletBinding(DefaultParameterSetName = "__Build")]
Param(
  [Parameter(ParameterSetName = "__Create")]
  [switch]$Create
  ,
  [Parameter(ParameterSetName = "__Create", Position = 0, Mandatory)]
  [ValidateNotNullOrEmpty()]
  [string]$ProjectName = "Sample"
  ,
  [Parameter(ParameterSetName = "__Create", Position = 1)]
  [ValidateNotNullOrEmpty()]
  [string]$Author = $env:USERNAME
  ,
  [Parameter(ParameterSetName = "__Create", Position = 3)]
  [ValidateNotNullOrEmpty()]
  [version]$Version = "1.0.0"
  ,

  [Parameter(ParameterSetName = "__Build")]
  [switch]$Build
  ,
  [Parameter(ParameterSetName = "__Build")]
  [Parameter(ParameterSetName = "__Serve")]
  [string]$SourceDir = "."
  ,
  [Parameter(ParameterSetName = "__Build")]
  [Parameter(ParameterSetName = "__Serve")]
  [string]$OutputDir = "_build"
  ,

  [Parameter(ParameterSetName = "__Serve")]
  [switch]$Serve
  ,
  [Parameter(ParameterSetName = "__Serve")]
  [ValidateRange(1,65535)]
  [int]$Port = 3000
)

Write-Output "Building sphinx image..."
$sphinxContainerName = "${env:USERNAME}/sphinx"
#$sphinxContainer = docker.exe images -q $sphinxContainerName
#If ($null -eq $sphinxContainer) {
  docker.exe build --tag $sphinxContainerName .
  If ($LASTEXITCODE -ne 0) {
    Throw "Unable to build base image"
  }
#}

Switch ($PSCmdlet.ParameterSetName) {
  "__Create" {
    Write-Output "Creating..."
    docker.exe run -it --volume "${PSScriptRoot}:C:\project" $sphinxContainerName `
      sphinx-quickstart -p $ProjectName -a $Author -v $Version -q
  }
  "__Build" {
    Write-Output "Building..."
    docker.exe run -it --volume "${PSScriptRoot}:C:\project" $sphinxContainerName `
      sphinx-build -b html $SourceDir $OutputDir
  }
  "__Serve" {
    Write-Output "Serving..."
    docker.exe run -it --volume "${PSScriptRoot}:C:\project" --publish "3000:${Port}" $sphinxContainerName `
      sphinx-autobuild --host 0.0.0.0 --port $Port --ignore *.ps1 --ignore .dockerignore --ignore Dockerfile --ignore .git/ $SourceDir $OutputDir
  }
}
<#
$dockerArgs = @(
  "run",
  "-it",
  "--volume", "${PSScriptRoot}:C:\src",
  "--workdir", "C:\src",
  "--entrypoint", "powershell.exe"
  "python:3.7-windowsservercore-ltsc2016"
)
Start-Process "docker.exe" -ArgumentList $dockerArgs
#>