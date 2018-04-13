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

CALL "%SC_PYJA_HM%\Config\SSet-JDK-8-(x32).bat"
CALL "%SC_PYJA_HM%\Config\SSet-ActivePython-3.6.0-(x32).bat"

SET JAVA_HOME=%SC_J8_HM%
SET SC_JAVA_XMX=-Xmx512m

SET SC_GROOVY_JAR_FN=%SC_PYJA_HM%\Library\Groovy\2.4.13\embeddable\groovy-all-2.4.13-indy.jar

SET PYTHONHOME=%SC_PYTHON_HM%

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

ECHO Groovy jar file =^> %SC_GROOVY_JAR_FN%

ECHO Python home =^> %PYTHONHOME%
ECHO Jep jar file =^> %SC_JEP_JAR_FN%

"%SC_J8_X_FN%" "%SC_JAVA_XMX%" -cp "%SC_JEP_JAR_FN%";"%SC_GROOVY_JAR_FN%" -Djava.library.path="%SC_JEP_PN%" org.codehaus.groovy.tools.GroovyStarter --main groovy.ui.GroovyMain "%SC_MILO_PN%\%SC_THIS_JN%.groovy" %*

ENDLOCAL
