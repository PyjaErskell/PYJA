@ECHO OFF
SETLOCAL
MKDIR "%~DP0ecu"
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\vbc.exe /target:winexe "/out:%~DP0ecu\SToa.exe" "%~DP0src\SToa.vb"
