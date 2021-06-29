@ECHO OFF
SETLOCAL

SET __SAC_KAPA_HM=C:\ProgramData\Bichon Frise\Kapa
SET __SAC_JAVA_HM=%__SAC_KAPA_HM%\19.11.01\Vindue\x64\Amazon\Corretto\8.232.09.1
SET __SAC_PYTHON_HM=%__SAC_KAPA_HM%\19.01.22\Vindue\x64\Anaconda\5.1.0
SET __SAC_JEP_PN=%__SAC_PYTHON_HM%\Lib\site-packages\jep
SET __SAC_JEP_JAR_FN=%__SAC_JEP_PN%\jep-3.7.1.jar

SET PYTHONHOME=%__SAC_PYTHON_HM%
SET PATH=%PYTHONHOME%;%SystemRoot%\System32

SET __SAC_ARGS=%*
IF "%__SAC_ARGS%"=="" (
  SET __SAC_ARGS="%__SAC_JEP_PN%\console.py"
)

"%__SAC_JAVA_HM%\bin\java.exe" -classpath "%__SAC_JEP_JAR_FN%" -Djava.library.path="%__SAC_JEP_PN%" jep.Run %__SAC_ARGS%
