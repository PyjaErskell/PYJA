//---------------------------------------------------------------
// Global
//---------------------------------------------------------------

GC_TONO_ST = ORun.ol_st

CgManagementFactory = java.lang.management.ManagementFactory
CgSimpleDateFormat = java.text.SimpleDateFormat

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

gf_joc = { x_jo -> x_jo .getClass () } // (j)ava (o)bject's (c)lass
gf_cls = { x_cls_nm -> Class .forName (x_cls_nm) } // find class from string
gf_is_instance = { x_cls, x_jo -> x_cls .isInstance x_jo }
gf_to_s = { x_jo -> x_jo .toString () }
gf_sf = { x_format, Object ... x_args -> String .format ( x_format, * x_args ) }

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
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Akka', '2.5.19', 'akka-actor_2.12-2.5.19.jar' ),
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Akka', '2.5.19', 'akka-slf4j_2.12-2.5.19.jar' ),
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Apache', 'Commons', 'IO', '2.5', 'commons-io-2.5.jar' ),
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'JNA', '5.1.0', 'jna-5.1.0.jar' ),
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'JNA', '5.1.0', 'jna-platform-5.1.0.jar' ),
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Joda-Time', '2.10.1', 'joda-time-2.10.1.jar' ),
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Logback', '1.2.3', 'logback-classic-1.2.3.jar' ),
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Logback', '1.2.3', 'logback-core-1.2.3.jar' ),
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Scala', '2.12.8', 'lib', 'scala-library.jar' ),
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'SLF4J', '1.7.25', 'slf4j-api-1.7.25.jar' ),
  gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Typesafe', 'Config', '1.3.3', 'config-1.3.3.jar' ),
] .each { gp_add_jar it }

GC_AS = { ->
  final fu_lc = gf_cls ('org.slf4j.LoggerFactory') .ILoggerFactory
  final fu_jc = gf_cls ('ch.qos.logback.classic.joran.JoranConfigurator') .newInstance ()
  fu_jc.context = fu_lc
  fu_lc .reset ()
  final fu_xml_str = """
    <configuration>
      <statusListener class="ch.qos.logback.core.status.NopStatusListener" />
      <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <layout class="ch.qos.logback.classic.PatternLayout">
          <Pattern>
            [${ GC_TONO_PID .toString () .padLeft (6,'0') },%.-1level,%date{yyMMdd-HHmmss}] %msg%n
          </Pattern>
        </layout>
        <target>System.out</target>
      </appender>
      <appender name="ASYNC" class="ch.qos.logback.classic.AsyncAppender">
        <appender-ref ref="STDOUT" />
      </appender>
      <root level="DEBUG">
        <appender-ref ref="ASYNC" />
      </root>
      <logger name="akka.event.slf4j.Slf4jLogger" level="OFF" additivity="false" />
      <logger name="akka.event.EventStream" level="OFF" additivity="false" />
    </configuration>
  """
  fu_jc .doConfigure ( new java.io.ByteArrayInputStream (fu_xml_str.bytes) )
  final fu_cfg = gf_cls ('com.typesafe.config.ConfigFactory') .parseString '''
    akka {
     loggers = ["akka.event.slf4j.Slf4jLogger"]
     loglevel = "DEBUG"
     logging-filter = "akka.event.slf4j.Slf4jLoggingFilter"
     log-dead-letters-during-shutdown = off
    }
  '''
  gf_cls ('akka.actor.ActorSystem') .create ( 'GC_AS', fu_cfg )
} ()

GC_LOG = GC_AS.log

CgFilenameUtils = gf_cls 'org.apache.commons.io.FilenameUtils'
CgPlatform = gf_cls 'com.sun.jna.Platform'

gp_log_array = { xp_out = GC_LOG .&info, x_title, x_array ->
  xp_out "${x_title} => "
  x_array .eachWithIndex { bx2_it, bx2_idx -> xp_out "  ${ (bx2_idx+1) .toString() .padLeft(2) } : $bx2_it" }
}
gp_log_header = { xp_out = GC_LOG .&info, x_header, x_line_width = 60 ->
  xp_out '+' + '-' * x_line_width
  xp_out ": ${x_header}"
  xp_out '+' + '-' * x_line_width
}
gp_log_exception = { xp_out = GC_LOG .&error, x_title, x_ex_list ->
  gp_log_header xp_out, x_title
  x_ex_list .each { xp_out "  ${it}" }
}

gf_bn = { x_fn -> new File (x_fn) .name } // (b)ase (n)ame
gf_jn = { x_fn -> final fu_bn = gf_bn (x_fn); fu_bn .substring ( 0, fu_bn .lastIndexOf ('.') ) } // (j)ust (n)ame without extension
gf_xn = { x_fn -> CgFilenameUtils .getExtension x_fn } // e(x)tension (n)ame
gf_if = { x_it -> new File (x_it) .isFile () }
gf_id = { x_it -> new File (x_it) .isDirectory () }
gf_pn = { x_it, x_chedk_id = false -> ( x_chedk_id && gf_id (x_it) ) ? x_it : CgFilenameUtils .getFullPath (x_it) } // (p)ath (n)ame
gf_on = { x_it, x_chedk_id = false -> gf_bn gf_pn ( x_it, x_chedk_id ) } // f(o)lder (n)ame from path name

GC_MILO_NM = gf_bn GC_MILO_PN
GC_TONO_NM = gf_on GC_TONO_HM, true
GC_JAVA_HM = gf_ap gf_os_env ('SC_J8_HM')
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
    "ran on ${ CgSimpleDateFormat .newInstance ( 'yyyy-MM-dd HH:mm:ss' ) .format (GC_TONO_ST) }",
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

gp_os_exit = { x_ec -> System .exit ( (int) x_ec ) }

gp_before_exit = {  x_ec, x_ex_list = [] ->
  if ( x_ec != GC_EC_SUCCESS ) { gp_log_array ( GC_LOG .&debug, 'CLASSPATH', ClassLoader.systemClassLoader.URLs .collect { gf_to_kms it.file } .sort () ) } 
  if (x_ex_list) gp_log_exception "Following error occurs !!!", x_ex_list
  if ( x_ec != GC_EC_SUCCESS && ! x_ex_list ) { gp_log_header ( GC_LOG .&error, "Unknown error occurs !!!" ); }
  switch (x_ec) {
    case GC_EC_NONE : GC_LOG .error "Undefined exit code (GC_EC_NONE), check your logic !!!"; break
    case GC_EC_SHUTDOWN : GC_LOG .info "Exit from shutdown like ctrl+c, ..."; break
    default :
      if ( x_ec < 0 ) GC_LOG .error "Negative exit code ${x_ec}, should consider using a positive value !!!"
      else GC_LOG .info "Exit code => ${x_ec}"
      break
  }
  GC_LOG .info "Elapsed ${ gf_elapsed GC_TONO_ST, new Date () } ..."
  GC_AS .terminate ()
  gf_cls ('scala.concurrent.Await') .ready ( GC_AS .whenTerminated (), gf_cls ('scala.concurrent.duration.Duration') .Inf () )
  gf_cls ('org.slf4j.LoggerFactory') .ILoggerFactory .stop ()
}

__gav_gp_request_exit_was_processed = false
gp_request_exit = { x_ec, x_ex_list = [] ->
  if ( __gav_gp_request_exit_was_processed ) { return }
  __gav_gp_request_exit_was_processed = true
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
  gp_before_exit x_ec, x_ex_list
  pp2_exit ()
}

addShutdownHook { gp_request_exit ( GC_EC_SHUTDOWN, [ 'Shutdown occurred !!!' ] ) }

gp_sa = { x_jo, String x_a_nm, x_value -> x_jo [x_a_nm] = x_value } // (s)et (a)ttribute
gf_ga = { x_jo, String x_a_nm -> x_jo [x_a_nm] } // (g)et (a)ttribute

gf_wai = { x_msg = null ->
  def fu_marker = new Throwable ()
  def fu_st = org.codehaus.groovy.runtime.StackTraceUtils .sanitize (fu_marker) .stackTrace [ ( x_msg == null ) ? 2 : 1 ]
  def fu_msg = fu_st .with { "${className}.${methodName} [${ String .format ( '%04d', lineNumber ) }]" }
  if ( ! x_msg ) { return fu_msg }
  return "${fu_msg} ${x_msg}"
}

gp_xr = { final Closure xp_it -> // JavaF(x) (r)un
  javafx.application.Platform .runLater { xp_it () }
} 

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
    GC_LOG .info  "Java version => ${ gf_sys_props 'java.version' }"
    GC_LOG .info  "Groovy version => ${GroovySystem.version}"
    GC_LOG .info  "Scala version => ${ gf_cls ('scala.util.Properties') .versionNumberString () }"
    GC_LOG .info  "Akka version => ${ gf_cls ('akka.Version') .current () }"
    GC_LOG .debug "Java home => ${ gf_to_kms GC_JAVA_HM }"
    GC_LOG .debug "Total CPU => $GC_TOTAL_CPU"
    GC_LOG .debug "Total memory => ${ String .format '%,d', GC_TOTAL_MEMORY } bytes"
    GC_LOG .debug "Computer name => $GC_HOST_NM"
    GC_LOG .debug "Current user => $GC_CUSR"
    GC_LOG .debug "Process ID => $GC_TONO_PID"
    GC_LOG .info  "Start up path => ${ gf_to_mps GC_TONO_START_UP_PN }"
    if ( GC_TONO_ARGV .size () > 0 ) gp_log_array  'Arguments', GC_TONO_ARGV
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

import javafx.application.Application
import javafx.geometry.Pos
import javafx.scene.control.Button
import javafx.scene.layout.VBox
import javafx.scene.Scene
import javafx.stage.Screen
import javafx.stage.Stage

class WMain extends Application {
  def wl_ps
  final wu_bn = new Button ()
  def wv_cnt = Integer.MAX_VALUE - 20
  void start ( final Stage x_stage ) {
    GC_LOG .info gf_wai ()
    wl_ps = x_stage
    final nu_root = new VBox () .tap {
      alignment = Pos.CENTER
      spacing = 10
      children .addAll wu_bn
    }
    wu_bn .with {
      wn_set_pb_text wm_current ()
      onAction = { bx_ev ->
        GC_LOG .info text
        wn_set_pb_text wm_next ()        
      }
    }
    wl_ps .with {
      onShown = { bx_ev ->
        new Timer () .schedule ({ gp_xr { wu_bn .fire () } } as TimerTask, 0, 1 )
      }
      onCloseRequest = { bx_ev ->
        GC_LOG .info 'About to quit ...'
        gp_request_exit GC_EC_SUCCESS
      }
      title = GC_TONO_NM
      width = 350
      height = 150
      scene = new Scene (nu_root)
      wn_move_center ()
      show ()
      toFront ()
    }
  }
  def wm_current () { wv_cnt }
  def wm_next () {
    if ( wv_cnt >= Integer.MAX_VALUE ) { wv_cnt = 1 }
    else { wv_cnt ++ }
    wv_cnt
  }
  def wn_set_pb_text (x_cnt) { wu_bn.text = gf_sf 'Ciao, %,d !', x_cnt }
  def wn_move_center () {
    final nu_vb = Screen.primary.visualBounds
    final def ( nu_cx, nu_cy ) = [ nu_vb.width / 2, nu_vb.height / 2 ]
    wl_ps .with {
      x = nu_cx - width / 2
      y = nu_cy - height / 2
    }
  }
}

Object.metaClass.sp_body = {
  // 1 / 0
  Application .launch WMain
}

def sp_main () {
  sp_run ()
}

sp_main ()
