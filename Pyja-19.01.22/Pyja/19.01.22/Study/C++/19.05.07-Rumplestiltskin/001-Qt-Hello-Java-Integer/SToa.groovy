//---------------------------------------------------------------
// Global
//---------------------------------------------------------------

CgManagementFactory = java.lang.management.ManagementFactory
CgSimpleDateFormat = java.text.SimpleDateFormat

GC_ST = ORun.ol_st

GC_PYJA_NM = 'Pyja'
GC_PYJA_AU = 'Erskell' // (au)thor

GC_PJYA_CEN = 20
GC_PYJA_YEA = 19
GC_PYJA_MON =  1
GC_PYJA_DAY = 22

GC_PYJA_CD = String .format '%02d%02d.%02d.%02d', GC_PJYA_CEN, GC_PYJA_YEA ,GC_PYJA_MON, GC_PYJA_DAY // Pyja creation date
GC_PYJA_VR = String .format '%02d.%02d.%02d', GC_PYJA_YEA, GC_PYJA_MON, GC_PYJA_DAY                  // Pyja version with fixed length 8
GC_PYJA_V2 = "$GC_PYJA_YEA.$GC_PYJA_MON.$GC_PYJA_DAY"                                                // Pyja version without leading zero

GC_PYJA_VER_MAJ = GC_PYJA_YEA // Major 
GC_PYJA_VER_MIN = GC_PYJA_MON // Minor
GC_PYJA_VER_PAT = GC_PYJA_DAY // Patch

GC_KAPA_HM_SYM = '@^'
GC_PYJA_RT_SYM = '@`'
GC_PYJA_HM_SYM = '@~'
GC_MILO_PN_SYM = '@!'
GC_TONO_HM_SYM = '@*'

GC_EC_NONE     = -200
GC_EC_SHUTDOWN = -199
GC_EC_SUCCESS  = 0
GC_EC_ERROR    = 1

GC_FOSA = File.separator     // (fo)lder (s)ep(a)rator
GC_PASA = File.pathSeparator // (pa)th (s)ep(a)rator

GC_TONO_PID = CgManagementFactory.runtimeMXBean.name .split ('@') [0]

gp_println = System.out .&println
gp_add_jar = ORun .&on_add_jar
gp_add_java_library_path = ORun .&on_add_java_library_path

gf_joc = { x_jo -> x_jo .getClass () } // (j)ava (o)bject's (c)lass
gf_cls = { x_cls_nm -> Class .forName (x_cls_nm) } // find class from string
gf_to_s = { x_jo -> x_jo .toString () }
gf_sf = { x_format, Object ... x_args -> String .format ( x_format, * x_args ) }
gy_oy = { x_jo, x_yethod_nm, Object ... x_args ->
  try {
    x_jo ."$x_yethod_nm" (*x_args)
  } catch (bu2_ex) {
    gp_request_exit GC_EC_ERROR, gf_exception_to_list (bu2_ex)
  }
}
gf_ap = { x_it, x_canonical = true -> // absolute path
  final fu_fl = new File (x_it)
  x_canonical ? fu_fl.canonicalPath : fu_fl.absolutePath
}
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
gf_rm_px = { x_str, x_px -> ( x_str .startsWith (x_px) ) ? x_str .replaceFirst ( "^$x_px", '' ) : x_str } // px : prefix
gf_exception_to_list = { x_ex ->
  def fu_list = [ x_ex .toString () ]
  x_ex .stackTrace .each { fu_list << it }
  fu_list
}

GC_KAPA_HM = gf_ap gf_os_env ('SC_KAPA_HM')
GC_PYJA_RT = gf_ap gf_os_env ('SC_PYJA_RT')
GC_PYJA_HM = gf_ap gf_os_env ('SC_PYJA_HM')
GC_MILO_PN = gf_ap gf_os_env ('SC_MILO_PN')
GC_TONO_HM = gf_ap gf_os_env ('SC_TONO_HM')

gf_pj = { String ... x_args -> x_args .join '/' } // path join
gf_jar_pj = this .&gf_pj

gf_replace_with_px_symbol = { x_pn, x_px, x_px_symbol ->
  final fu_pn = gf_ap x_pn
  if ( fu_pn .startsWith (x_px) ) {
    gf_pj ( x_px_symbol, fu_pn [ x_px .length () + 1 .. -1 ] )
  } else {fu_pn}
}

gf_to_khs = { x_pn -> gf_replace_with_px_symbol x_pn, GC_KAPA_HM, GC_KAPA_HM_SYM } // to (k)apa (h)ome (s)ymbol
gf_to_prs = { x_pn -> gf_replace_with_px_symbol x_pn, GC_PYJA_RT, GC_PYJA_RT_SYM } // to (p)yja (r)oot (s)ymbol
gf_to_phs = { x_pn -> gf_replace_with_px_symbol x_pn, GC_PYJA_HM, GC_PYJA_HM_SYM } // to (p)yja (h)ome (s)ymbol
gf_to_mps = { x_pn -> gf_replace_with_px_symbol x_pn, GC_MILO_PN, GC_MILO_PN_SYM } // to (m)ilo (p)ath (s)ymbol
gf_to_ths = { x_pn -> gf_replace_with_px_symbol x_pn, GC_TONO_HM, GC_TONO_HM_SYM } // to (t)ono (h)ome (s)ymbol
gf_to_kms = { x_pn -> fu_khs = gf_to_khs x_pn; ( x_pn == fu_khs ) ?  ( gf_to_mps (x_pn) ) : fu_khs } // to khs or mps

[
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Apache', 'Commons', 'IO', '2.5', 'commons-io-2.5.jar' ),
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'JNA', '5.1.0', 'jna-5.1.0.jar' ),
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'JNA', '5.1.0', 'jna-platform-5.1.0.jar' ),
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Joda-Time', '2.10.1', 'joda-time-2.10.1.jar' ),
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Logback', '1.2.3', 'logback-classic-1.2.3.jar' ),
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Logback', '1.2.3', 'logback-core-1.2.3.jar' ),
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'SLF4J', '1.7.25', 'slf4j-api-1.7.25.jar' ),
] .each { gp_add_jar it }

GC_LOG = { ->
  gf_cls ('org.slf4j.LoggerFactory') .ILoggerFactory .with { bx2_lc ->
    reset ()
    getLogger ('GC_LOG') .tap {
      addAppender ( gf_cls ('ch.qos.logback.core.ConsoleAppender') .newInstance () .with { bx4_ca ->
        context = bx2_lc
        encoder = gf_cls ('ch.qos.logback.classic.encoder.PatternLayoutEncoder') .newInstance () .with {
          context = bx2_lc
          pattern = "[${ GC_TONO_PID .toString () .padLeft (6,'0') },%.-1level,%date{yyMMdd-HHmmss}] %msg%n"
          start ()
          it
        }
        start ()
        bx4_ca
      } )
    }
  }
} ()

CgFilenameUtils = gf_cls 'org.apache.commons.io.FilenameUtils'
CgPlatform = gf_cls 'com.sun.jna.Platform'

gp_set_log_level_to_info  = { GC_LOG.level = gf_cls ('ch.qos.logback.classic.Level') .INFO }
gp_set_log_level_to_warn  = { GC_LOG.level = gf_cls ('ch.qos.logback.classic.Level') .WARN }
gp_set_log_level_to_debug = { GC_LOG.level = gf_cls ('ch.qos.logback.classic.Level') .DEBUG }
gp_set_log_level_to_trace = { GC_LOG.level = gf_cls ('ch.qos.logback.classic.Level') .TRACE }
gp_log_array = { xp_out = GC_LOG .&info, x_title, x_array ->
  xp_out "${x_title} => "
  x_array .eachWithIndex { bx2_it, bx2_idx -> xp_out "  ${ (bx2_idx+1) .toString() .padLeft(2) } : $bx2_it" }
}
gp_log_header = { xp_out = GC_LOG .&info, x_header, x_line_width = 60 ->
  xp_out '+' + '-' * x_line_width
  xp_out ": ${x_header}"
  xp_out '+' + '-' * x_line_width
}
gp_log_exception = { xp_out = GC_LOG .&error, x_title, x_ex ->
  gp_log_header xp_out, x_title
  x_ex .each { xp_out "  ${it}" }
}

gf_bn = { x_fn -> new File (x_fn) .name } // (b)ase (n)ame
gf_jn = { x_fn -> final fu_bn = gf_bn (x_fn); fu_bn .substring ( 0, fu_bn .lastIndexOf ('.') ) } // (j)ust (n)ame without extension
gf_xn = { x_fn -> CgFilenameUtils .getExtension x_fn } // e(x)tension (n)ame
gf_if = { x_it -> new File (x_it) .isFile () }
gf_id = { x_it -> new File (x_it) .isDirectory () }
gf_pn = { x_it, x_chedk_id = false -> ( x_chedk_id && gf_id (x_it) ) ? x_it : CgFilenameUtils .getFullPath (x_it) } // (p)ath (n)ame
gf_on = { x_it, x_chedk_id = false -> gf_bn gf_pn ( x_it, x_chedk_id ) } // f(o)lder (n)ame from path name

GC_JAVA_VR = gf_sys_props 'java.version'
GC_GROOVY_VR = GroovySystem.version

GC_MILO_NM = gf_bn GC_MILO_PN
GC_TONO_NM = gf_on GC_TONO_HM, true
GC_JAVA_HM = gf_ap gf_os_env ('SC_J8_HM')
GC_QT_HM = gf_ap gf_os_env ('SC_QT_HM')
GC_TOTAL_CPU = Runtime.runtime .availableProcessors ()
GC_TOTAL_MEMORY = CgManagementFactory.operatingSystemMXBean.totalPhysicalMemorySize
GC_HOST_NM = InetAddress.localHost.hostName
GC_CUSR = gf_sys_props 'user.name'
GC_TONO_START_UP_PN = gf_ap '.'
GC_TONO_OS_ENV_PATHS = gf_os_env ('SC_PATH') .split (GC_PASA)
GC_TONO_ARGV = ORun.ol_args

gf_banner = { x_leading_space = 0, x_margin_inside = 2 ->
  final fu_msgs = [
    "$GC_PYJA_NM $GC_PYJA_V2",
    GC_MILO_NM,
    GC_TONO_NM,
    '',
    "made by $GC_PYJA_AU",
    "ran on ${ CgSimpleDateFormat .newInstance ( 'yyyy-MM-dd HH:mm:ss' ) .format (GC_ST) }",
    'released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.',
  ]
  final fu_msl = fu_msgs .collect { it .size () } .max () // max string length
  final fu_ls = x_leading_space // leading space before box
  final fu_mg = x_margin_inside // margin inside box
  final fu_ll = fu_mg + fu_msl + fu_mg // line length inside box
  def ff2_get_line = { -> ' ' * fu_ls + '+' + '-' * fu_ll + '+' }
  def ff2_get_string = { x2_str ->
    final fu2_sl = x2_str .size () // string lentgh
    final fu2_lm = (Integer) ( ( fu_ll - fu2_sl ) / 2.0 ) // left margin inside box
    final fu2_rm = fu_ll - ( fu2_sl + fu2_lm ) // right margin inside box
    return ' ' * fu_ls + ':' + ' ' * fu2_lm + x2_str + ' ' * fu2_rm + ':' 
  }
  final fu_r = [ ff2_get_line () ] + fu_msgs .collect { ff2_get_string (it) } + [ ff2_get_line () ]
  return fu_r
}

gf_elapsed = { x_st, x_et ->
  final fu_pd = gf_cls ('org.joda.time.Interval') .newInstance ( x_st.time, x_et.time ) .toPeriod ()
  fu_pd .with { String .format '%02d-%02d-%02d %02d:%02d:%02d.%03d', years, months ,days, hours, minutes, seconds, millis }
}
gp_os_exit = { x_ec -> System .exit x_ec }

__gav_request_exit_was_called = false
gp_request_exit = { x_ec, x_ex = [] ->
  if (__gav_request_exit_was_called) return
  __gav_request_exit_was_called = true
  def pp2_before_exit = {
    if ( x_ec != GC_EC_SUCCESS ) { gp_log_array ( GC_LOG .&debug, 'CLASSPATH', ClassLoader.systemClassLoader.URLs .collect { gf_to_kms it.file } .sort () ) } 
    if (x_ex) gp_log_exception "Following error occurs !!!", x_ex
    if ( x_ec != GC_EC_SUCCESS && !x_ex ) { gp_log_header ( GC_LOG .&error, "Unknown error occurs !!!" ); }
    switch (x_ec) {
      case GC_EC_NONE : GC_LOG .error "Undefined exit code (GC_EC_NONE), check your logic !!!"; break
      case GC_EC_SHUTDOWN : GC_LOG .info "Exit from shutdown like ctrl+c, ..."; break
      default :
        if ( x_ec < 0 ) GC_LOG .error "Negative exit code ${x_ec}, should consider using a positive value !!!"
        else GC_LOG .info "Exit code => ${x_ec}"
        break
    }
    GC_LOG .info "Elapsed ${ gf_elapsed GC_ST, new Date () } ..."
  }
  def pp2_exit = {
    switch (x_ec) {
      case GC_EC_NONE : gp_os_exit (GC_EC_ERROR); break
      case GC_EC_SHUTDOWN : break
      default :
        if ( x_ec < 0 ) gp_os_exit (GC_EC_ERROR)
        else  gp_os_exit (x_ec)
        break
    }
  }
  pp2_before_exit ()
  pp2_exit ()
}
addShutdownHook { gp_request_exit ( GC_EC_SHUTDOWN, [ 'Shutdown occurred !!!' ] ) }

gp_sa = { x_jo, String x_a_nm, x_value -> x_jo [x_a_nm] = x_value } // (s)et (a)ttribute
gf_ga = { x_jo, String x_a_nm -> x_jo [x_a_nm] } // (g)et (a)ttribute

__gap_export_all_to_object_meta_class = {
  this.binding.variables .each { x_key, x_value -> if ( ! x_key .startsWith ('_') ) { Object.metaClass."$x_key" = x_value } }
}
__gap_export_all_to_object_meta_class ()

//---------------------------------------------------------------
// Main Skeleton
//---------------------------------------------------------------

def sp_run () {
  pp2_begin = {
    println gf_banner () .join ('\n')
    GC_LOG .debug "Pyja name => $GC_PYJA_NM"
    if ( GC_PYJA_NM != gf_os_env ('SC_PYJA_NM') ) throw new Exception ( 'Invalid Pyja name !!!' )
    GC_LOG .debug "Pyja creation date => $GC_PYJA_CD"
    if ( ! gf_str_is_valid_date ( GC_PYJA_CD, 'yyyy.mm.dd' ) ) throw new Exception ( 'Pyja create date is not invalid !!!' )
    GC_LOG .debug "Pyja version => $GC_PYJA_V2"
    if ( GC_PYJA_VR != gf_os_env ('SC_PYJA_VR') ) throw new Exception ( 'Invalid Pyja version !!!' )
    GC_LOG .info  "Kapa home ($GC_KAPA_HM_SYM) => $GC_KAPA_HM"
    GC_LOG .info  "Pyja root ($GC_PYJA_RT_SYM) => $GC_PYJA_RT"
    GC_LOG .info  "Pyja home ($GC_PYJA_HM_SYM) => ${ gf_to_prs (GC_PYJA_HM) }"
    GC_LOG .info  "Milo path ($GC_MILO_PN_SYM) => ${ gf_to_phs (GC_MILO_PN) }"
    GC_LOG .info  "Tono home ($GC_TONO_HM_SYM) => ${ gf_to_mps GC_TONO_HM }"
    GC_LOG .info  "Is 64 bit? => ${ CgPlatform .is64Bit () }"
    GC_LOG .info  "Java version => $GC_JAVA_VR"
    GC_LOG .info  "Groovy version => $GC_GROOVY_VR"
    GC_LOG .debug "Java home => ${ gf_to_kms GC_JAVA_HM }"
    GC_LOG .debug "Qt home => ${ gf_to_kms GC_QT_HM }"
    GC_LOG .debug "Total CPU => $GC_TOTAL_CPU"
    GC_LOG .debug "Total memory => ${ String .format '%,d', GC_TOTAL_MEMORY } bytes"
    GC_LOG .debug "Computer name => $GC_HOST_NM"
    GC_LOG .debug "Current user => $GC_CUSR"
    GC_LOG .debug "Process ID => $GC_TONO_PID"
    GC_LOG .info  "Start up path => ${ gf_to_mps GC_TONO_START_UP_PN }"
    gp_log_array  GC_LOG .&debug, 'Paths', GC_TONO_OS_ENV_PATHS
    if ( GC_TONO_ARGV .size () > 0 ) gp_log_array GC_LOG .&debug, 'Arguments', GC_TONO_ARGV
  }
  try {
    pp2_begin ()
    sp_body ()
  } catch (bu2_ex) {
    gp_request_exit GC_EC_ERROR, gf_exception_to_list (bu2_ex)
  }
}

//---------------------------------------------------------------
// Your Source
//---------------------------------------------------------------

class CInteger {
  private __cav_value = Integer.MAX_VALUE - 20
  def cm_current () { __cav_value; }
  def cm_next () { __can_change_value (); __cav_value; }
  private def __can_change_value () {
    if ( __cav_value >= Integer.MAX_VALUE ) { __cav_value = 1 }
    else { __cav_value ++ }
  }
}

Object.metaClass.sp_body = {
  // 1 / 0
}

def sp_main () {
  // gp_set_log_level_to_info ()
  sp_run ()
}

sp_main ()

