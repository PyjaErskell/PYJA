@ECHO OFF
SETLOCAL

CALL "%~DP0\SCommon.bat"
"%SC_ECU_PN%\SToa" %*
