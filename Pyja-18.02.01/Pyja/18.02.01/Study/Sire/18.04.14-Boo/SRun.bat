@ECHO OFF
SETLOCAL

SET PATH=%SystemRoot%\system32

SET SC_THIS_BN=%~NX0
SET SC_THIS_JN=%~N0

PUSHD "%~DP0"
CD "%~DP0"
SET SC_MILO_PN=%CD%
CD "%SC_MILO_PN%\..\..\.."
SET SC_PYJA_HM=%CD%
FOR %%F IN (%SC_PYJA_HM%) DO SET SC_PYJA_VR=%%~NXF
CD "%SC_PYJA_HM%\.."
SET SC_PYJA_RT=%CD%
FOR %%F IN (%SC_PYJA_RT%) DO SET SC_PYJA_NM=%%~NXF
POPD

CALL "%SC_PYJA_HM%\Config\SSet-JDK-8.bat"
CALL "%SC_PYJA_HM%\Config\SSet-Anaconda3-5.1.0.bat"
CALL "%SC_PYJA_HM%\Config\SSet-Sire-8.bat"

SET JAVA_HOME=%SC_J8_HM%
SET SC_JAVA_XMX=-Xmx9g

SET PYTHONHOME=%SC_PYTHON_HM%

SET PATH=%SC_J8_HM%\jre\bin\server;%PATH%
SET PATH=%SC_J8_HM%\bin;%PATH%
SET PATH=%SC_PYTHON_HM%;%PATH%
SET SC_PATH=%PATH%

ECHO PATH =^> %SC_PATH%

ECHO MILO path =^> %SC_MILO_PN%
ECHO PYJA name =^> %SC_PYJA_NM%
ECHO PYJA version =^> %SC_PYJA_VR%
ECHO PYJA root =^> %SC_PYJA_RT%
ECHO PYJA home =^> %SC_PYJA_HM%

ECHO Java home =^> %JAVA_HOME%
ECHO Java maximum heap size option =^> %SC_JAVA_XMX%

ECHO Python home =^> %PYTHONHOME%

ECHO Sire home =^> %SC_SIRE_HM%

CD %SC_SIRE_HM%

IF [%1] == [] (
  ECHO First argument not given
  GOTO SAS_START
)
ECHO First argument =^> %1
IF EXIST %1 (
  SET SC_WFD_FN=%1
  GOTO SAS_START
)
SET __sau_try_wfd_fn=%SC_MILO_PN%\%1\%1.wfd
ECHO Workflow file to try =^> %__sau_try_wfd_fn%
IF EXIST %__sau_try_wfd_fn% (
  SET SC_WFD_FN=%__sau_try_wfd_fn%
  GOTO SAS_START
)
IF NOT EXIST %__sau_try_wfd_fn% (
  ECHO Cannot find workflow file to try
)

:SAS_START

IF [%SC_WFD_FN%] == [] (
  ECHO Lauching without workflow file
) ELSE (
  ECHO Launching with workflow file %SC_WFD_FN%
)

START "" /B "%SC_SIRE_X_FN%" %SC_WFD_FN%

ENDLOCAL
