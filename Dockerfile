# escape=`
FROM python:3.7-windowsservercore-ltsc2016
SHELL ["powershell.exe", "-Command", "$ErrorActionPreference='Stop';$ProgressPreference='SilentlyContinue';"]

RUN python -m pip install --upgrade pip ; pip install -U sphinx ; pip install -U sphinx-autobuild

VOLUME C:\project
WORKDIR /project
ENTRYPOINT [ "powershell.exe", "-Command" ]