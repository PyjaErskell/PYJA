//---------------------------------------------------------------
// Global
//---------------------------------------------------------------

GC_DUCK_ST = OYela.ol_st

GC_FOSA = File.separator // (fo)lder (s)ep(a)rator
GC_PASA = File.pathSeparator // (pa)th (s)ep(a)rator

CgFilenameUtils = org.apache.commons.io.FilenameUtils
CgManagementFactory = java.lang.management.ManagementFactory
CgSimpleDateFormat = java.text.SimpleDateFormat

gf_joc = { x_jo -> x_jo .getClass () } // (j)ava (o)bject's (c)lass
gf_cls = { x_cls_nm -> Class .forName (x_cls_nm) } // find class from string
gf_is_instance = { x_jo, x_cls -> x_cls .isInstance x_jo }
gf_sf = { x_format, Object ... x_args -> String .format ( x_format, * x_args ) } // (s)tring (f)ormat
gf_ni = { x_cls, Object ... x_args -> x_cls .newInstance ( * x_args ) } // (n)ew (i)nstance

gf_os_env = { x_key ->
  final fu_it = System .getenv x_key
  if ( fu_it == null ) { throw new NullPointerException ( "Environment variable not found => ${x_key}" ) }
  fu_it
}
gf_os_env_has = { x_key -> System .getenv (x_key) != null }

gf_sys_props = { x_key ->
  final fu_it = System .getProperty (x_key)
  if ( fu_it == null ) { throw new NullPointerException ( "System property not found => ${x_key}" ) }
  fu_it
}
gp_sys_props_set = { x_key, x_value -> System .setProperty ( x_key, x_value ) }

gf_str_is_valid_date = { x_str, x_format ->
  def fv_is_valid = true
  try { CgSimpleDateFormat .newInstance (x_format) .with { it .setLenient (false); it .parse (x_str) } } catch (_) { fv_is_valid = false }
  fv_is_valid
}

gf_exception_to_list = { x_ex ->
  final fu_list = [ x_ex .toString () ]
  x_ex .stackTrace .each { fu_list << it .toString () }
  fu_list
}

gf_classpaths = { -> ClassLoader.systemClassLoader.URLs .collect { it .toString () } .sort () }

gf_elapsed = { x_st, x_et ->
  final fu_pd = new org.joda.time.Interval ( x_st.time, x_et.time ) .toPeriod ()
  fu_pd .with { String .format '%02d-%02d-%02d %02d:%02d:%02d.%03d', years, months ,days, hours, minutes, seconds, millis }
}

gf_jep = { x_include_pn -> new jep.Jep ( false, x_include_pn ) }

__gap_make_globals = { -> this.binding.variables .each { x2_key, x2_value -> if ( ! x2_key .startsWith ('_') ) { Object.metaClass."$x2_key" = x2_value } } }
__gap_make_globals ()

//---------------------------------------------------------------
// Your Source
//---------------------------------------------------------------

1
