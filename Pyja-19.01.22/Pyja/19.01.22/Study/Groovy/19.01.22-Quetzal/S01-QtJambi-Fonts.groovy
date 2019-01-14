//
// Global
//

class Global {
  static GC_ST = new Date ()

  static GC_PYJA_NM = 'Pyja'
  static GC_PYJA_AU = 'Erskell' // (au)thor

  static GC_PJYA_CEN = 20
  static GC_PYJA_YEA = 19
  static GC_PYJA_MON =  1
  static GC_PYJA_DAY = 22

  static GC_PYJA_CD = String .format '%02d%02d.%02d.%02d', GC_PJYA_CEN, GC_PYJA_YEA ,GC_PYJA_MON, GC_PYJA_DAY // Pyja creation date
  static GC_PYJA_VR = String .format '%02d.%02d.%02d', GC_PYJA_YEA, GC_PYJA_MON, GC_PYJA_DAY                  // Pyja version with fixed length 8
  static GC_PYJA_V2 = "$GC_PYJA_YEA.$GC_PYJA_MON.$GC_PYJA_DAY"                                                // Pyja version without leading zero

  static GC_PYJA_VER_MAJ = GC_PYJA_YEA // Major 
  static GC_PYJA_VER_MIN = GC_PYJA_MON // Minor
  static GC_PYJA_VER_PAT = GC_PYJA_DAY // Patch

  static GC_PYJA_RT_SYM = '@`'
  static GC_PYJA_HM_SYM = '@~'
  static GC_MILO_PN_SYM = '@!'

  static GC_EC_NONE     = -200
  static GC_EC_SHUTDOWN = -199
  static GC_EC_SUCCESS  = 0
  static GC_EC_ERROR    = 1

  static GC_FOSA = File.separator     // (fo)lder (s)ep(a)rator
  static GC_PASA = File.pathSeparator // (pa)th (s)ep(a)rator

  static GC_SCRIPT_FN
  static GC_APP_NM
  static GC_ARGV

  static CgManagementFactory = java.lang.management.ManagementFactory
  static CgSimpleDateFormat = java.text.SimpleDateFormat

  static GC_THIS_START_UP_PN = gf_ap '.'
  static GC_OS_ENV_PATHS = gf_os_env ('SC_PATH') .split (GC_PASA)

  static GC_KAPA_HM   = gf_ap gf_os_env ( 'SC_KAPA_HM' )
  static GC_PYJA_RT   = gf_ap gf_os_env ( 'SC_PYJA_RT' )
  static GC_PYJA_HM   = gf_ap gf_os_env ( 'SC_PYJA_HM' )
  static GC_GROOVY_HM = gf_ap gf_os_env ( 'SC_GROOVY_HM' )
  static GC_MILO_PN   = gf_ap gf_os_env ( 'SC_MILO_PN' )
  
  static GC_JAVA_VR = gf_sys_props ('java.version')
  static GC_GROOVY_VR = GroovySystem.version

  static GC_THIS_PID = CgManagementFactory.runtimeMXBean.name .split ('@') [0]
  static GC_TOTAL_CPU = Runtime.runtime .availableProcessors ()
  static GC_TOTAL_MEMORY = CgManagementFactory.operatingSystemMXBean.totalPhysicalMemorySize
  static GC_HOST_NM = InetAddress.localHost.hostName
  static GC_CUSR = gf_sys_props ('user.name')

  def static gf_os_env (x_key) {
    final fu_it = System .getenv x_key
    if ( fu_it == null ) { throw new NullPointerException ( "Environment variable not found => ${x_key}" ) }
    fu_it
  }
  def static gf_sys_props (x_key) {
    final fu_it = System .getProperty (x_key)
    if ( fu_it == null ) { throw new NullPointerException ( "System property not found => ${x_key}" ) }
    fu_it
  }
  def static gf_str_is_valid_date ( x_str, x_format ) {
    def fv_is_valid = true
    try { CgSimpleDateFormat .newInstance (x_format) .with { it .setLenient (false); it .parse (x_str) } } catch (_) { fv_is_valid = false }
    fv_is_valid
  }
  def static gf_rm_px ( x_str, x_px ) { ( x_str .startsWith (x_px) ) ? x_str .replaceFirst ( "^$x_px", '' ) : x_str } // px : prefix
  def static gf_exception_to_list (x_ex) {
    def fu_list = [ x_ex.toString () ]
    x_ex .stackTrace .findAll { ! ( it =~ /\.java:\d+\)$/ ) } .each { fu_list << it }
    fu_list
  }
  def static gp_sr = { Closure xp_it -> javax.swing.SwingUtilities .invokeLater { xp_it () } } // (S)wing (r)un
  def static gf_cls = { x_cls_nm -> Class .forName (x_cls_nm) }
  def static gy_ge (x_str) { Eval .me x_str }

  def static gf_b2fs (x_it) { x_it .replaceAll "\\\\", "/" } // replace backslash to forwardslash
  def static gf_ap ( x_it, x_canonical = true ) { // absolute path
    final fu_fl = new File (x_it)
    gf_b2fs x_canonical ? fu_fl.canonicalPath : fu_fl.absolutePath
  }
  def static gf_pj ( String ... x_args ) { x_args .join '/' } // path join
  def static gf_jar_pj = this.&gf_pj

  def static gp_add_jar (x_jar_fn) {
    if ( ! gf_if (x_jar_fn) ) { throw new FileNotFoundException ( "JAR file not found => ${x_jar_fn}" ) }
    final pu_url = new File (x_jar_fn) .toURI () .toURL ()
    final pu_cl = ClassLoader.systemClassLoader
    final pu_m = URLClassLoader.class .getDeclaredMethod 'addURL', URL.class
    pu_m.accessible = true
    pu_m .invoke pu_cl, pu_url
  }
  def static gp_add_java_library_path (x_java_library_pn) {
    if ( ! gf_id (x_java_library_pn) ) { throw new FileNotFoundException ( "Java library path not found => $x_java_library_pn" ) }
    final pu_org_paths = gf_sys_props ('java.library.path')
    System .setProperty ( 'java.library.path', pu_org_paths + GC_PASA + x_java_library_pn )
    final pu_f = ClassLoader.class .getDeclaredField ('sys_paths')
    pu_f .accessible = true
    pu_f .set null, null
  }

  def static gf_banner ( x_leading_space = 0, x_margin_inside = 2 ) {
    final fu_msgs = [
      "$GC_PYJA_NM $GC_APP_NM",
      "made by $GC_PYJA_AU",
      '',
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

  def static gf_replace_with_px_symbol ( x_pn, x_px_path, x_px_symbol ) {
    final fu_pn = gf_ap x_pn
    if ( fu_pn .startsWith (x_px_path) ) {
      gf_pj ( x_px_symbol, fu_pn [ x_px_path .length () + 1 .. -1 ] )
    } else {fu_pn}
  }
  def static gf_to_prs (x_pn) { // to (p)yja (r)oot (s)ymbol
    gf_replace_with_px_symbol ( x_pn, GC_PYJA_RT, GC_PYJA_RT_SYM )
  }
  def static gf_to_phs (x_pn) { // to (p)yja (h)ome (s)ymbol
    gf_replace_with_px_symbol ( x_pn, GC_PYJA_HM, GC_PYJA_HM_SYM )
  }
  def static gf_to_mps (x_pn) { // to (m)ilo (p)ath (s)ymbol
    gf_replace_with_px_symbol ( x_pn, GC_MILO_PN, GC_MILO_PN_SYM )
  }

  static GC_LOG = { ->
    [
      gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Apache', 'Commons', 'IO', '2.5', 'commons-io-2.5.jar' ),
      gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Joda-Time', '2.10.1', 'joda-time-2.10.1.jar' ),
      gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Logback', '1.2.3', 'logback-classic-1.2.3.jar' ),
      gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'Logback', '1.2.3', 'logback-core-1.2.3.jar' ),
      gf_jar_pj ( GC_KAPA_HM, '19.01.22', 'Cumuni', 'SLF4J', '1.7.25', 'slf4j-api-1.7.25.jar' ),
    ] .each { gp_add_jar it }
    gf_cls ('org.slf4j.LoggerFactory') .ILoggerFactory .with { bx2_lc ->
      reset ()
      getLogger ('GC_LOG') .with { bx3_log ->
        addAppender ( gf_cls ('ch.qos.logback.core.ConsoleAppender') .newInstance () .with { bx4_ca ->
          context = bx2_lc
          encoder = gf_cls ('ch.qos.logback.classic.encoder.PatternLayoutEncoder') .newInstance () .with {
            context = bx2_lc
            pattern = "[${ GC_THIS_PID .toString () .padLeft (6,'0') },%.-1level,%date{yyMMdd-HHmmss}] %msg%n"
            start ()
            it
          }
          start ()
          bx4_ca
        } )
        bx3_log
      }
    }
  } ()
  def static gp_set_log_level_to_info  = { GC_LOG.level = gf_cls('ch.qos.logback.classic.Level').INFO }
  def static gp_set_log_level_to_warn  = { GC_LOG.level = gf_cls('ch.qos.logback.classic.Level').WARN }
  def static gp_set_log_level_to_debug = { GC_LOG.level = gf_cls('ch.qos.logback.classic.Level').DEBUG }
  def static gp_set_log_level_to_trace = { GC_LOG.level = gf_cls('ch.qos.logback.classic.Level').TRACE }
  def static gp_log_array = { xp_out = GC_LOG.&info, x_title, x_array ->
    xp_out "${x_title} => "
    x_array.eachWithIndex { bx2_it, bx2_idx -> xp_out "  ${ (bx2_idx+1) .toString() .padLeft(2) } : $bx2_it" }
  }
  def static gp_log_header = { xp_out = GC_LOG.&info, x_header, x_line_width = 60 ->
    xp_out '+' + '-' * x_line_width
    xp_out ": ${x_header}"
    xp_out '+' + '-' * x_line_width
  }
  def static gp_log_exception = { xp_out = GC_LOG.&error, x_title, x_ex ->
    gp_log_header xp_out, x_title
    x_ex .each { xp_out "  ${it}" }
  }

  static CgFilenameUtils = gf_cls ('org.apache.commons.io.FilenameUtils')

  def static gf_bn (x_fn) { new File (x_fn) .name } // (b)ase (n)ame
  def static gf_jn (x_fn) { final fu_bn = gf_bn (x_fn); fu_bn .substring ( 0, fu_bn .lastIndexOf ('.') ) } // (j)ust (n)ame without extension
  def static gf_xn (x_fn) { CgFilenameUtils .getExtension x_fn } // e(x)tension (n)ame
  def static gf_fn (x_fn) { gf_b2fs x_fn } // (f)ile (n)ame
  def static gf_pn (x_fn) { gf_b2fs CgFilenameUtils .getFullPath (x_fn) } // (p)ath (n)ame
  def static gf_on (x_pn) { new File(x_pn).name } // f(o)lder (n)ame from path name
  def static gf_if (x_it) { new File (x_it) .isFile () }
  def static gf_id (x_it) { new File (x_it) .isDirectory () }

  def static gf_elapsed ( x_st, x_et ) {
    final fu_pd = gf_cls ('org.joda.time.Interval') .newInstance ( x_st.time, x_et.time ) .toPeriod ()
    fu_pd .with { String .format '%02d-%02d-%02d %02d:%02d:%02d.%03d', years, months ,days, hours, minutes, seconds, millis }
  }
  def static gp_os_exit (x_ec) { System .exit x_ec }
  private static __gav_request_exit_was_called = false
  def static gp_request_exit = { x_ec, x_ex = [] ->
    if (__gav_request_exit_was_called) return
    __gav_request_exit_was_called = true
    def pp2_before_exit = {
      if ( x_ec != GC_EC_SUCCESS ) { gp_log_array ( GC_LOG.&debug, 'CLASSPATH', ClassLoader.systemClassLoader.URLs .collect { it .toString () } .sort () ) } 
      if (x_ex) gp_log_exception "Following error occurs !!!", x_ex
      if ( x_ec != GC_EC_SUCCESS && !x_ex ) { gp_log_header ( GC_LOG.&error, "Unknown error occurs !!!" ); }
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
  def static gp_qapp_exec () { try { return QApplication .exec () } catch (bu2_ex) { return QApplication .execStatic () } }
}

import static Global.*

import com.trolltech.qt.core.Qt
import com.trolltech.qt.gui.QApplication

gp_set_log_level_to_debug ()

GC_SCRIPT_FN = gf_fn this.class.protectionDomain.codeSource.location.path
GC_APP_NM = gf_jn GC_SCRIPT_FN
GC_ARGV = args

addShutdownHook { gp_request_exit ( GC_EC_SHUTDOWN, [ 'Shutdown occurred !!!' ] ) }

//
// Main Skeleton
//

class DRun {
  def static dp_it ( Closure xp_it ) {
    try {
      __dap_begin ()
      xp_it ()
    } catch (bu2_ex) {
      gp_request_exit GC_EC_ERROR, gf_exception_to_list (bu2_ex)
    }
  }
  private def static __dap_begin () {
    println gf_banner () .join ('\n')
    GC_LOG .debug "Pyja name => $GC_PYJA_NM"
    if ( GC_PYJA_NM != gf_os_env ('SC_PYJA_NM') ) throw new Exception ( 'Invalid Pyja name !!!' )
    GC_LOG .debug "Pyja creation date => $GC_PYJA_CD"
    if ( ! gf_str_is_valid_date ( GC_PYJA_CD, 'yyyy.mm.dd' ) ) throw new Exception ( 'Pyja create date is not invalid !!!' )
    GC_LOG .debug "Pyja version => $GC_PYJA_V2"
    if ( GC_PYJA_VR != gf_os_env ('SC_PYJA_VR') ) throw new Exception ( 'Invalid Pyja version !!!' )
    GC_LOG .info  "Pyja root ($GC_PYJA_RT_SYM) => $GC_PYJA_RT"
    GC_LOG .info  "Pyja home ($GC_PYJA_HM_SYM) => ${ gf_to_prs (GC_PYJA_HM) }"
    GC_LOG .info  "Milo path ($GC_MILO_PN_SYM) => ${ gf_to_phs (GC_MILO_PN) }"
    GC_LOG .info  "Java version => $GC_JAVA_VR"
    GC_LOG .info  "Groovy version => $GC_GROOVY_VR"
    GC_LOG .info  "Total CPU => $GC_TOTAL_CPU"
    GC_LOG .info  "Total memory => ${ String .format '%,d', GC_TOTAL_MEMORY } bytes"
    GC_LOG .debug "Computer name => $GC_HOST_NM"
    GC_LOG .debug "Current user => $GC_CUSR"
    GC_LOG .debug "Process ID => $GC_THIS_PID"
    GC_LOG .info  "Start up path => ${ gf_to_phs GC_THIS_START_UP_PN }"
    GC_LOG .info  "Script file => ${ gf_to_mps GC_SCRIPT_FN }"
    gp_log_array  GC_LOG.&debug, 'Paths', GC_OS_ENV_PATHS
    if ( GC_ARGV .size () > 0 ) gp_log_array  'Arguments', GC_ARGV
  }
}

//
// Your Source
//

import com.trolltech.qt.core.QTimerEvent
import com.trolltech.qt.gui.QCloseEvent
import com.trolltech.qt.gui.QDesktopWidget
import com.trolltech.qt.gui.QFont
import com.trolltech.qt.gui.QFontDatabase
import com.trolltech.qt.gui.QLabel
import com.trolltech.qt.gui.QMainWindow
import com.trolltech.qt.gui.QPushButton
import com.trolltech.qt.gui.QShowEvent
import com.trolltech.qt.gui.QSizePolicy
import com.trolltech.qt.gui.QVBoxLayout
import com.trolltech.qt.gui.QWidget

class WQtMain extends QMainWindow {
  final wu_wgt
  final wu_cw
  final wu_lo
  final wu_pb
  final wu_lb
  final wu_fnt_families
  def wv_fnt_idx
  def wv_msg
  WQtMain () {
    windowTitle = GC_APP_NM
    wu_cw = new QWidget ()
    wu_lo = new QVBoxLayout ()
    wu_pb = new QPushButton () .with {
      setSizePolicy QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Fixed
      it.pressed.connect this, 'won_change_font()'
      it
    }
    wu_lb = new QLabel () .with {
      alignment = Qt.AlignmentFlag.AlignCenter
      it
    }
    [ new QWidget (), wu_pb, wu_lb ] .each { wu_lo .addWidget it }
    wu_cw.layout = wu_lo
    wu_fnt_families = new QFontDatabase () .families ()
    GC_LOG .info "${this.class.name} : Total fonts => ${wu_fnt_families.size}"
    wv_fnt_idx = wu_fnt_families.size - 1
    wv_msg = ''
    wn_change_font ()

    setCentralWidget wu_cw
    resize 650, 250
    wn_move_center ()
    show ()
    raise ()

    startTimer 100
  }
  def wn_change_font () {
    if ( wv_fnt_idx >= wu_fnt_families.size ) wv_fnt_idx = 0
    final nu_fnt_nm = wu_fnt_families [wv_fnt_idx]
    if ( wv_msg != '' ) GC_LOG .info "QtJambi -> $wv_msg"
    final nu_nt = "(${wv_fnt_idx+1}/${wu_fnt_families.size})"
    wv_msg = "0^0 $nu_nt ($nu_fnt_nm)"
    wu_pb .with {
      text = "Say '$wv_msg'"
      font = new QFont ( nu_fnt_nm, 18 )
    }
    wu_lb.text = "$nu_nt Font name : $nu_fnt_nm"
    wn_move_center ()
    wv_fnt_idx ++
  }
  void won_change_font () { wn_change_font () }
  def wn_move_center () {
    final nu_cp = new QDesktopWidget () .availableGeometry () .center () // center point
    move nu_cp .x () - (Integer) ( width () / 2 ), nu_cp .y () - (Integer) ( height () / 2 )
  }
  void timerEvent ( QTimerEvent x_ev ) {
    wn_change_font ()
  }
  void showEvent ( QShowEvent x_ev ) {
    GC_LOG .info "${this.class.name} => showEvent"
  }
  void closeEvent ( QCloseEvent x_ev ) {
    GC_LOG .info "${this.class.name} => closeEvent"
  }
}

class DBody {
  def static dp_it () {
    def pv_ec = GC_EC_NONE
    QApplication .initialize ( [] as String [] )
    new WQtMain ()
    pv_ec = gp_qapp_exec ()
    gp_request_exit pv_ec
  }
}

class OStart {
  def static main () {
    // gp_set_log_level_to_info ()
    DRun .dp_it DBody.&dp_it
  }
}

OStart .main ()
