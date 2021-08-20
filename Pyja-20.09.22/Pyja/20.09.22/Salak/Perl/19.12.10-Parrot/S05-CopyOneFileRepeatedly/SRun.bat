@ECHO OFF
SETLOCAL

SET SC_KAPA_HM=C:\ProgramData\Bichon Frise\Kapa

SET SC_JAVA_HM=%SC_KAPA_HM%\19.11.01\Vindue\x64\Amazon\Corretto\8.232.09.1
SET Path=%SC_JAVA_HM%\jre\bin\server;%Path%

SET SC_PYTHON_HM=%SC_KAPA_HM%\19.01.22\Vindue\x64\Anaconda\5.1.0
SET QT_PLUGIN_PATH=%SC_PYTHON_HM%\Library\plugins
SET SC_JEP_PN=%SC_PYTHON_HM%\Lib\site-packages\jep
SET SC_JEP_JAR_FN=%SC_JEP_PN%\jep-3.7.1.jar
SET PYTHONHOME=%SC_PYTHON_HM%
SET Path=%SC_PYTHON_HM%;%Path%

PUSHD "%~DP0"
CD "%~DP0"

SET SC_MILO_PN=%CD%
CD "%SC_MILO_PN%\..\..\..\.."
SET SC_PYJA_HM=%CD%
FOR %%F IN (%SC_PYJA_HM%\..) DO SET SC_PYJA_NM=%%~NXF
FOR %%F IN (%SC_PYJA_HM%) DO SET SC_PYJA_VR=%%~NXF

POPD

SET SC_ECU_PN=%SC_MILO_PN%\ecu

"%SC_KAPA_HM%\19.01.22\Vindue\x64\Strawberry\5.28.1\perl\bin\perl5.28.1.exe" -CS -I "%SC_MILO_PN%\src\k-09001-perl" "%SC_MILO_PN%\src\k-01001-run-me\SToa.pl" %*
