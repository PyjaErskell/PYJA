/*
Designer Variables: su_it
*/

load ( [ java.lang.System .getenv ("SC_PYJA_HM"), "Program", "Hepager", "ScriptRunner", "Global", "18.05.29-Jep.js" ] .join (java.io.File.separator) )
gp_set_log_level_to_info ()
gp_run_py ( [ "Hepager", "ScriptRunner", "Text", "Shuffle", "18.05.30-Shuffle-Values.py" ] )
