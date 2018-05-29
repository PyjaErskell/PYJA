@ECHO OFF
SETLOCAL

SET PATH=%SystemRoot%\system32

SET SC_THIS_BN=%~NX0
SET SC_THIS_JN=%~N0

PUSHD "%~DP0"
CD "%~DP0"
SET SC_MILO_PN=%CD%
CD "%SC_MILO_PN%\..\..\..\.."
SET SC_PYJA_HM=%CD%
FOR %%F IN (%SC_PYJA_HM%) DO SET SC_PYJA_VR=%%~NXF
CD "%SC_PYJA_HM%\.."
SET SC_PYJA_RT=%CD%
FOR %%F IN (%SC_PYJA_RT%) DO SET SC_PYJA_NM=%%~NXF
POPD

CALL "%SC_PYJA_HM%\Config\SSet-JDK-8.bat"
CALL "%SC_PYJA_HM%\Config\SSet-Anaconda3-5.1.0.bat"
CALL "%SC_PYJA_HM%\Config\SSet-InDesign-2018.bat"

SET PYTHONHOME=%SC_PYTHON_HM%

SET PATH=%SC_J8_HM%\bin;%PATH%
SET PATH=%SC_PYTHON_HM%;%PATH%
SET SC_PATH=%PATH%

ECHO PATH =^> %SC_PATH%

ECHO MILO path =^> %SC_MILO_PN%
ECHO PYJA name =^> %SC_PYJA_NM%
ECHO PYJA version =^> %SC_PYJA_VR%
ECHO PYJA root =^> %SC_PYJA_RT%
ECHO PYJA home =^> %SC_PYJA_HM%

ECHO Python home =^> %PYTHONHOME%
ECHO Jep jar file =^> %SC_JEP_JAR_FN%

ECHO Java home =^> %SC_J8_HM%

"%SC_ID_2018_X_FN%" %*

ENDLOCAL
