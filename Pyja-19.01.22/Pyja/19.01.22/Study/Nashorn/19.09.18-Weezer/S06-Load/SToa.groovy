gu_gr = this.binding.variables
gy_na_f = { x_name, Object ... x_args -> gu_na ."$x_name" .call ( gu_na, * x_args ) }
gu_na .getClass () .metaClass .methodMissing = { x_name, x_args -> gy_na_f ( x_name, x_args ) }
GC_TONO_HM = gu_na.GC_TONO_HM
GC_KAPA_HM = gu_na.GC_KAPA_HM
GC_FOSA = gu_na.GC_FOSA
GC_PASA = gu_na.GC_PASA
GC_KAPA_HM_SYM = '@^'
GC_MILO_PN_SYM = '@!'
GC_TONO_HM_SYM = '@*'
gf_cls = { x_cls_nm -> Class .forName (x_cls_nm) } // find class from string
CgFilenameUtils = gf_cls 'org.apache.commons.io.FilenameUtils'
CgPlatform = gf_cls 'com.sun.jna.Platform'
CgSimpleDateFormat = java.text.SimpleDateFormat
gf_bn = { x_fn -> new File (x_fn) .name } // (b)ase (n)ame
gf_jn = { x_fn -> final fu_bn = gf_bn (x_fn); fu_bn .substring ( 0, fu_bn .lastIndexOf ('.') ) } // (j)ust (n)ame without extension
gf_xn = { x_fn -> CgFilenameUtils .getExtension x_fn } // e(x)tension (n)ame
gf_xi = { x_it -> new File (x_it) .exists () }
gf_if = { x_it -> new File (x_it) .isFile () }
gf_id = { x_it -> new File (x_it) .isDirectory () }
gf_pn = { x_it, x_chedk_id = false -> ( x_chedk_id && gf_id (x_it) ) ? x_it : CgFilenameUtils .getFullPath (x_it) } // (p)ath (n)ame
gf_on = { x_it, x_chedk_id = false -> gf_bn gf_pn ( x_it, x_chedk_id ) } // f(o)lder (n)ame from path name
gf_joc = { x_jo -> x_jo .getClass () } // (j)ava (o)bject's (c)lass
gf_is_instance = { x_cls, x_jo -> x_cls .isInstance x_jo }
gf_to_s = { x_jo -> x_jo .toString () }
gf_sf = { x_format, Object ... x_args -> String .format ( x_format, * x_args ) }
gf_ap = { x_it, x_canonical = true -> // absolute path
  final fu_fl = new File (x_it)
  x_canonical ? fu_fl.canonicalPath : fu_fl.absolutePath
}
gf_pj = { String ... x_args -> x_args .join GC_FOSA } // path join
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
gf_str_is_valid_date = { x_str, x_format ->
  def fv_is_valid = true
  try { CgSimpleDateFormat .newInstance (x_format) .with { it .setLenient (false); it .parse (x_str) } } catch (_) { fv_is_valid = false }
  fv_is_valid
}
gf_exception_to_list = { x_ex ->
  def fu_list = [ x_ex .toString () ]
  x_ex .stackTrace .each { fu_list << it .toString () }
  fu_list
}
gf_replace_with_px_symbol = { x_pn, x_px, x_px_symbol ->
  final fu_pn = ( ( gf_xi (x_pn) ) ? gf_ap (x_pn) : x_pn ) .replace '\\', '/'
  final fu_px = x_px .replace '\\', '/'
  final fu_px_sz = fu_px .length ()
  def fv_idx = 0
  String .join x_px_symbol, fu_pn .split ( java.util.regex.Pattern .quote (fu_px) ) .collect { it .length () } .collect {
    final bx2_it = x_pn .substring ( fv_idx, fv_idx + it )
    fv_idx += it + fu_px_sz
    bx2_it
  }
}
gf_to_khs = { x_pn -> gf_replace_with_px_symbol x_pn, GC_KAPA_HM, GC_KAPA_HM_SYM } // to (k)apa (h)ome (s)ymbol
gf_to_mps = { x_pn -> gf_replace_with_px_symbol x_pn, GC_MILO_PN, GC_MILO_PN_SYM } // to (m)ilo (p)ath (s)ymbol
gf_to_ths = { x_pn -> gf_replace_with_px_symbol x_pn, GC_TONO_HM, GC_TONO_HM_SYM } // to (t)ono (h)ome (s)ymbol
gp_add_jar = { x_jar_fn ->
  if ( ! gf_if (x_jar_fn) ) { throw new FileNotFoundException ( "JAR file not found => ${x_jar_fn}" ) }
  final pu_url = new File (x_jar_fn) .toURI () .toURL ()
  final pu_cl = ClassLoader.systemClassLoader
  final pu_m = URLClassLoader.class .getDeclaredMethod 'addURL', URL.class
  pu_m.accessible = true
  pu_m .invoke pu_cl, pu_url
}
gp_add_java_library_path = { x_java_library_pn ->
  if ( ! gf_id (x_java_library_pn) ) { throw new FileNotFoundException ( "Java library path not found => $x_java_library_pn" ) }
  final pu_org_paths = gf_sys_props ('java.library.path')
  System .setProperty ( 'java.library.path', pu_org_paths + GC_PASA + x_java_library_pn )
  final pu_f = ClassLoader.class .getDeclaredField ('sys_paths')
  pu_f .accessible = true
  pu_f .set null, null
}
gp_sa = { x_jo, String x_a_nm, x_value -> x_jo [x_a_nm] = x_value } // (s)et (a)ttribute
gf_ga = { x_jo, String x_a_nm -> x_jo [x_a_nm] } // (g)et (a)ttribute
gf_wai = { x_msg = null ->
  def fu_marker = new Throwable ()
  def fu_st = org.codehaus.groovy.runtime.StackTraceUtils .sanitize (fu_marker) .stackTrace [ ( x_msg == null ) ? 2 : 1 ]
  def fu_msg = fu_st .with { "${className}.${methodName} [${ String .format ( '%04d', lineNumber ) }]" }
  if ( ! x_msg ) { return fu_msg }
  return "${fu_msg} ${x_msg}"
}
gf_respond_to = { x_jo, String x_yethod_nm -> x_jo.metaClass .respondsTo x_jo, x_yethod_nm }
gy_call_if_exist = { x_jo, x_yethod_nm, Object ... x_args -> if ( gf_respond_to ( x_jo, x_yethod_nm ) ) { x_jo ."$x_yethod_nm" ( * x_args ) } }
gf_file_text = { x_fn, x_encoding = 'UTF-8' ->
  if ( ! gf_if (x_fn) ) { throw new FileNotFoundException ( "File not found => ${x_fn}" ) }
  new File (x_fn) .getText (x_encoding)
}
GC_MILO_PN = gf_ap gf_pj ( GC_TONO_HM, '..' )
gf_new_python = { ->
  { ->
    final pu2_pn = gf_pj GC_KAPA_HM, "19.01.22", "Vindue", "x96", "JACOB", "1.19"
    final pu2_fn = gf_pj pu2_pn, 'jacob.jar'
    gp_add_java_library_path pu2_pn
    gp_add_jar pu2_fn
  } ()
  final fu_axc = gf_cls 'com.jacob.activeX.ActiveXComponent'
  final fu_disp = gf_cls 'com.jacob.com.Dispatch'
  final fu_rbo = fu_axc .newInstance ('ruby.object.2.4')
  final fu_python_hm = gf_pj GC_KAPA_HM, '19.01.22', 'Vindue', 'x64', 'Anaconda', '5.1.0'
  fu_disp .call fu_rbo, 'erubyize', """
    GC_KAPA_HM = '${GC_KAPA_HM}'
    GC_FOSA = File::ALT_SEPARATOR
    GC_PASA = File::PATH_SEPARATOR
    def gf_os_env x_key; ENV .fetch x_key.to_s; end
    def gp_set_os_env x_key, x_val; ENV[x_key.to_s] = x_val; end
    def gf_pj *x_args; x_args .join GC_FOSA; end
    -> () {
      pu_python_hm = '${fu_python_hm}'
      gp_set_os_env :PATH, ( [ pu_python_hm, ( gf_pj gf_os_env(:SystemRoot), 'System32' ), ] .join GC_PASA )
      gp_set_os_env :PYTHONHOME, pu_python_hm
      gp_set_os_env :PYTHONPATH, ( ( eval `python -c "import sys\nprint (sys.path)"` ) .join GC_PASA )
      gp_set_os_env :QT_QPA_PLATFORM_PLUGIN_PATH, ( gf_pj pu_python_hm, "Library", "plugins" )
      gp_set_os_env :QT_AUTO_SCREEN_SCALE_FACTOR, '1'
    } .()
  """ .toString ()
  { ->
    final pu2_pn = gf_pj fu_python_hm, 'Lib', 'site-packages', 'jep'
    final pu2_fn = gf_pj pu2_pn, 'jep-3.7.1.jar'
    gp_add_java_library_path pu2_pn
    gp_add_jar pu2_fn
  } ()
  final fu_it = gf_cls ('jep.Jep') .newInstance false, '.'
  fu_it
}

gf_py_e = { x_str -> gy_py_f ( 'gf_py_e', x_str ) }
gp_py_x = { x_str -> GC_PY .eval (x_str) }
gf_py_g = { x_key -> GC_PY .getValue (x_key) }
gp_py_s = { x_key, x_val -> GC_PY .set ( x_key, x_val ) }
gy_py_f = { x_name, Object ... x_args -> GC_PY .invoke ( x_name, x_args ); }

gp_make_globals = { -> this.binding.variables .each { x2_key, x2_value -> if ( ! x2_key .startsWith ('_') ) { Object.metaClass."$x2_key" = x2_value } } }

sp_test = { ->
  println "+--------------------------------------------------------------------"
  println ": Groovy"
  println "+--------------------------------------------------------------------"
  println "[GR] Milo path ($GC_MILO_PN_SYM) => $GC_MILO_PN"
  println "[GR] Tono home ($GC_TONO_HM_SYM) => ${ gf_to_mps GC_TONO_HM }"
  println "[GR] Kapa home ($GC_KAPA_HM_SYM) => $GC_KAPA_HM"
  println "[GR] Folder Separator => $GC_FOSA"
  println "[GR] Path Separator => " + GC_PASA
  println "[GR] Java command => ${ gf_sys_props ('sun.java.command') }"
  println "[GR] Java version => ${ gf_sys_props 'java.version' }"
  println "[GR] Groovy version => ${GroovySystem.version}"
  println "[GR] GC_GR class name => ${GC_GR.class.name}"
  println "[GR] GC_PY class name => ${GC_PY.class.name}"
  println "[GR] gu_na class name => ${ gu_na .getClass () .name }"
  println "[GR] gu_gr class name => ${ gu_gr .getClass () .name }"
  println "[GR] Call gu_na's function => ${ gu_na .sf_sum ( 1, 20, 3000000000000000 ) }"
  println "[GR] Call GC_PY's function => ${ gy_py_f ( 'sf_sum', 11111111111, 222222222222222, 333 ) }"
}
