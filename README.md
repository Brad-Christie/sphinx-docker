# Sphinx on Windows (w/ Docker)

Don't want to install python? Still want to develop using Sphinx documentation? This repo's for you.

Leveraging the python container, we can create, build and develop sphinx documentation.

## .\Sphinx.ps1 -Create -Project "Example" -Author "Me" -Version "1.0.0"

Creates an "Example" project, authored by "Me" defined as version "1.0.0"

## .\Sphinx.ps1 -Build [-SourceDir .] [-OutputDir _build]

Builds the sphinx documentation.

## .\Sphinx.ps1 -Serve [-Port 3000] [-SourceDir .] [-OutputDir _build]

Builds and hosts the sphinx documentation, while also serving it (and watching for changes).
