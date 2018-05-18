#
# Ruby (Global)
#

GC_ST = Time.now

GC_PYJA_NM = 'Pyja'

GC_PJYA_CEN = 20
GC_PYJA_YEA = 18
GC_PYJA_MON =  2
GC_PYJA_DAY =  1

GC_PYJA_CD = '%02d%02d.%02d.%02d' % [ GC_PJYA_CEN, GC_PYJA_YEA, GC_PYJA_MON, GC_PYJA_DAY ] # Pyja creation date
GC_PYJA_VR = '%02d.%02d.%02d' % [ GC_PYJA_YEA, GC_PYJA_MON, GC_PYJA_DAY ]                  # Pyja version with fixed length 8
GC_PYJA_V2 = '%d.%d.%d' % [ GC_PYJA_YEA, GC_PYJA_MON, GC_PYJA_DAY ]                        # Pyja version without leading zero

GC_PYJA_VER_MAJ = GC_PYJA_YEA # Major 
GC_PYJA_VER_MIN = GC_PYJA_MON # Minor
GC_PYJA_VER_PAT = GC_PYJA_DAY # Patch

GC_PYJA_RT_SYM = '@`'
GC_PYJA_HM_SYM = '@~'
GC_MILO_PN_SYM = '@!'

GC_EC_NONE     = -200
GC_EC_SHUTDOWN = -199
GC_EC_SUCCESS  = 0
GC_EC_ERROR    = 1

GC_FOSA = File::SEPARATOR      # (fo)lder (s)ep(a)rator
GC_PASA = File::PATH_SEPARATOR # (pa)th (s)ep(a)rator

GC_RUBY_VR = RUBY_VERSION

require 'date'
require 'etc'
require 'fileutils'
require 'hash_dot'
require 'heredoc_unindent'
require 'logger'
require 'socket'

Hash.use_dot_syntax = true

GC_TOTAL_CPU = Etc.nprocessors
GC_HOST_NM = Socket.gethostname
GC_CUSR = Etc.getlogin  # current user
GC_THIS_PID = Process.pid

def gf_os_env x_it; ENV .fetch x_it.to_s; end
def gp_set_const x_sym, x_val; Object .const_set x_sym, x_val; end
def gf_str_is_valid_date x_str, x_format; Date .strptime x_str, x_format; end
def gf_rm_px x_str, x_px # px : prefix
  ( x_str .start_with? x_px ) ? x_str [ x_px.size .. -1 ] : x_str
end

GC_OS_ENV_PATHS = ( gf_os_env :SC_PATH ) .split GC_PASA

def gf_bn x_fn; File .basename x_fn; end
def gf_ap x_it; File .expand_path x_it; end
def gf_fn x_it; File .expand_path x_it; end
def gf_jn x_fn; File .basename x_fn, File .extname(x_fn); end
def gf_xn x_fn
  fu_list = ( File .basename x_fn ) .split ('.')
  return ( fu_list.size < 2 ) ? '' : fu_list [-1]
end
def gf_xi x_it; File .exist? x_it; end 
def gf_id x_it; File .directory? x_it; end
def gf_if x_it; File .file? x_it; end
def gf_pj *x_args; File .join x_args; end
def gp_mp x_pn; FileUtils .mkdir_p x_pn if not gf_id x_pn; end
def gp_rp x_pn # (r)emove (p)ath
  FileUtils .remove_dir x_pn if gf_id x_pn
end
def gp_ep x_pn  # (e)mpty out (p)ath
  return unless gf_id x_pn
  ( Dir .glob gf_pj x_pn, '*' ) .each { |it|
    if gf_id x_pn
      FileUtils .remove_dir it
    else
      FileUtils .rm it
    end
  }
end
def gf_pn x_fn; fu_ap = gf_ap x_fn; File .dirname x_fn; end
def gf_on x_pn; fu_ap = gf_ap x_pn; gf_bn fu_ap; end
def gf_on_list x_it
  fu_pn = if gf_if (x_it); gf_pn (x_it); else; gf_ap (x_it); end
  fu_pn .split File::SEPARATOR
end

GC_ARGV = ARGV

GC_PYJA_RT  = gf_ap gf_os_env(:SC_PYJA_RT)
GC_PYJA_HM  = gf_ap gf_os_env(:SC_PYJA_HM)
GC_MILO_PN  = gf_ap gf_os_env(:SC_MILO_PN)

def gf_banner x_leading_space = 0, x_margin_inside = 2
  fu_msgs = [
    "#{GC_PYJA_NM} #{GC_APP_NM}",
    '',
    "ran on #{ Time .now .strftime ('%F %T') }",
    'released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.',
  ]
  fu_msl = fu_msgs .map { |bx2_it| bx2_it.size } .max # max string length
  fu_ls = x_leading_space # leading space before box
  fu_mg = x_margin_inside # margin inside box
  fu_ll = fu_mg + fu_msl + fu_mg # line length inside box

  ff2_get_line = ->() { return ' ' * fu_ls + '+' + '-' * fu_ll + '+' }
  ff2_get_string = ->(x2_str) {
    fu2_sl = x2_str.size # string lentgh
    fu2_lm = ( ( fu_ll - fu2_sl ) / 2.0 ) .to_i # left margin inside box
    fu2_rm = fu_ll - ( fu2_sl + fu2_lm ) # right margin inside box
    return ' ' * fu_ls + ':' + ' ' * fu2_lm + x2_str + ' ' * fu2_rm + ':' 
  }
  fu_r = [ff2_get_line.()] + fu_msgs .map { |bx2_msg| ff2_get_string.(bx2_msg) } + [ff2_get_line.()]
  return fu_r
end

GC_JAVA_HM  = gf_ap gf_os_env(:SC_J8_HM)
GC_RUBY_HM = gf_os_env(:SC_RUBY_HM)

GC_THIS_START_UP_PN = gf_ap Dir.getwd

GC_SCRIPT_FN = gf_fn $0
GC_SCRIPT_PN = gf_pn GC_SCRIPT_FN
GC_APP_NM = gf_jn GC_SCRIPT_FN

def gf_replace_with_px_symbol x_pn, x_px_path, x_px_symbol
  fu_pn = gf_ap x_pn
  if fu_pn.start_with? x_px_path
    gf_pj x_px_symbol, fu_pn [ x_px_path.size + 1 .. -1 ]
  else
    fu_pn
  end
end
def gf_to_prs x_pn # to (p)yja (r)oot (s)ymbol
  gf_replace_with_px_symbol x_pn, GC_PYJA_RT, GC_PYJA_RT_SYM
end
def gf_to_phs x_pn # to (p)yja (h)ome (s)ymbol
  gf_replace_with_px_symbol x_pn, GC_PYJA_HM, GC_PYJA_HM_SYM
end
def gf_to_mps x_pn # to (m)ilo (p)ath (s)ymbol
  gf_replace_with_px_symbol x_pn, GC_MILO_PN, GC_MILO_PN_SYM
end

def gf_bi x_bo; x_bo.object_id; end # ru(b)y (i)d
def gf_bo x_bi; ObjectSpace._id2ref x_bi; end # ru(b)y (o)bject

def gp_bn x_bi, x_nethod_nm, *x_args # call ru(b)y (n)ethod
  pu_bo = gf_bo (x_bi)
  pu_bo.send x_nethod_nm, *x_args if pu_bo .respond_to? x_nethod_nm
end

#
# Java (Global)
#

require 'rjb'

JC_GROOVY_JAR_FN = gf_pj GC_PYJA_HM, 'Library', 'Groovy', '2.4.15', 'embeddable', 'groovy-all-2.4.15-indy.jar'
JC_QTJ_JAR_FN = gf_os_env(:SC_QTJ_JAR_FN)

->() {
  pu_igir_jar_fn = ( gf_pj GC_MILO_PN, 'IgIR.jar' )
  raise RuntimeError, "Can't find IgIR jar file => #{pu_igir_jar_fn}" unless gf_if pu_igir_jar_fn
  pu_groovy_jar_fn = JC_GROOVY_JAR_FN
  raise RuntimeError, "Can't find groovy jar file => #{pu_groovy_jar_fn}" unless gf_if pu_groovy_jar_fn
  pu_qtj_jar_fn = JC_QTJ_JAR_FN
  raise RuntimeError, "Can't find QtJambi jar file => #{pu_qtj_jar_fn}" unless gf_if pu_qtj_jar_fn
  pu_qtj_lib_pn = gf_os_env(:SC_QTJ_LIB_PN)
  raise RuntimeError, "Can't find QtJambi library path => #{pu_qtj_lib_pn}" unless gf_id pu_qtj_lib_pn
  pu_class_path = [ pu_igir_jar_fn, pu_groovy_jar_fn, pu_qtj_jar_fn ] .join GC_PASA
  Rjb::load pu_class_path, [ gf_os_env(:SC_JAVA_XMX), "-Djava.library.path=#{pu_qtj_lib_pn}" ]
}.()

JC_GR = ( Rjb::import 'javax.script.ScriptEngineManager' ) .new .getEngineByName ('Groovy')
def jy_ge x_str; JC_GR .eval x_str; end
def jy_gf x_nm, *x_args; JC_GR. invokeFunction x_nm, x_args; end
def jy_gm x_oj, x_nm, *x_args; JC_GR. invokeMethod x_oj, x_nm, x_args; end
def jy_gc x_closure, *x_args
  yu_closure = x_closure.kind_of?(String) ? jy_ge(x_closure) : x_closure
  jy_gm yu_closure, 'call', *x_args
end
JC_GROOVY_VR = ( jy_ge 'GroovySystem.version' ) .toString
JC_QTJ_VR = ( jy_ge 'com.trolltech.qt.QtInfo .versionString ()' ) .toString

jy_ge <<-JASH_EOS.unindent
  gf_tid = { Thread .currentThread () .getId () }
  GC_THIS_TID = gf_tid ()
JASH_EOS
jy_ge <<-JASH_EOS.unindent
  GC_ST = new Date () .parse ( 'yyyy-MM-dd HH:mm:ss', '#{ GC_ST .strftime '%F %T' }' )
  Object.metaClass.GC_APP_NM = '#{GC_APP_NM}'
  Object.metaClass.GC_EC_NONE     = #{GC_EC_NONE}
  Object.metaClass.GC_EC_SHUTDOWN = #{GC_EC_SHUTDOWN}
  Object.metaClass.GC_EC_SUCCESS  = #{GC_EC_SUCCESS}
  Object.metaClass.GC_EC_ERROR    = #{GC_EC_ERROR}
  Object.metaClass.GC_THIS_PID = #{GC_THIS_PID}
JASH_EOS
jy_ge <<-JASH_EOS.unindent
  gp_puts = { final x_str -> println x_str }
  gp_add_jar = { final String x_jar_fn ->
    if ( ! new File (x_jar_fn) .exists () ) { throw new FileNotFoundException ( "JAR file not found => ${x_jar_fn}" ) }
    final URL pu_url = new File (x_jar_fn) .toURI () .toURL ()
    final URLClassLoader pu_cl = ClassLoader .getSystemClassLoader ()
    final fu_m = URLClassLoader.class .getDeclaredMethod 'addURL', URL.class
    fu_m.setAccessible true
    fu_m.invoke pu_cl, pu_url
  }
JASH_EOS
def jp_puts x_str; jy_gf 'gp_puts', x_str; end
def jf_jcls x_cls_nm; Rjb::import x_cls_nm; end
def jp_add_jar x_jar_fn; jy_gf 'gp_add_jar', x_jar_fn; end
def jf_al_to_a x_al, x_mn_sym; ( 0 ... x_al .size ) .map { |bx2_idx| ( x_al .get bx2_idx ) .send x_mn_sym } ; end # java.util.ArrayList to array

CjBoolean = jf_jcls 'java.lang.Boolean'
CjByte    = jf_jcls 'java.lang.Byte'
CjChar    = jf_jcls 'java.lang.Character'
CjDouble  = jf_jcls 'java.lang.Double'
CjFloat   = jf_jcls 'java.lang.Float'
CjInteger = jf_jcls 'java.lang.Integer'
CjLong    = jf_jcls 'java.lang.Long'
CjShort   = jf_jcls 'java.lang.Short'
CjString  = jf_jcls 'java.lang.String'
CjSystem  = jf_jcls 'java.lang.System'

JC_QAPP = jf_jcls 'com.trolltech.qt.gui.QApplication'
JC_GR .put 'GC_QAPP', JC_QAPP

JC_JAVA_VR = CjSystem .getProperty 'java.version'

[ 
  ( gf_pj GC_PYJA_HM, 'Library', 'JNA', '4.5.1', 'jna-4.5.1.jar' ),
  ( gf_pj GC_PYJA_HM, 'Library', 'JNA', '4.5.1', 'jna-platform-4.5.1.jar' ),
  ( gf_pj GC_PYJA_HM, 'Library', 'Logback', '1.2.3', 'logback-classic-1.2.3.jar' ),
  ( gf_pj GC_PYJA_HM, 'Library', 'Logback', '1.2.3', 'logback-core-1.2.3.jar' ),
  ( gf_pj GC_PYJA_HM, 'Library', 'SLF4J', '1.7.25', 'slf4j-api-1.7.25.jar' ),
] .each { |bu2_jar_fn| jp_add_jar bu2_jar_fn }

CjPlatform  = jf_jcls 'com.sun.jna.Platform'

jy_ge <<-JASH_EOS.unindent
  GC_LOG = org.slf4j.LoggerFactory .getILoggerFactory () .with { bx2_lc ->
    reset ()
    getLogger ("GC_LOG") .with { bx3_log ->
      addAppender ( new ch.qos.logback.core.ConsoleAppender () .with { bx4_ca ->
        setContext (bx2_lc)
        setEncoder ( new ch.qos.logback.classic.encoder.PatternLayoutEncoder () .with {
          setContext (bx2_lc)
          setPattern ( "[${ String.format ( '%06d', GC_THIS_PID ) },%.-1level,%date{yyMMdd-HHmmss}] %msg%n" )
          start ()
          it
        } )
        start ()
        bx4_ca
      } )
      bx3_log
    }
  }
  gp_set_log_level_to_info  = { GC_LOG.level = ch.qos.logback.classic.Level.INFO }
  gp_set_log_level_to_warn  = { GC_LOG.level = ch.qos.logback.classic.Level.WARN }
  gp_set_log_level_to_debug = { GC_LOG.level = ch.qos.logback.classic.Level.DEBUG }
  gp_set_log_level_to_trace = { GC_LOG.level = ch.qos.logback.classic.Level.TRACE }
  gp_set_log_level_to_debug ()
  gp_log_array = { final xp_out = GC_LOG.&info, final x_title, final x_array ->
    xp_out "${x_title} => "
    x_array.eachWithIndex { final bx2_it, final bx2_idx -> xp_out "  ${ (bx2_idx+1) .toString() .padLeft(2) } : $bx2_it" }
  }
  gp_log_header = { final xp_out = GC_LOG.&info, final x_header, final x_line_width = 60 ->
    xp_out '+' + '-' * x_line_width
    xp_out ": ${x_header}"
    xp_out '+' + '-' * x_line_width
  }
  gp_log_exception = { final xp_out = GC_LOG.&error, final x_title, final x_ex ->
    gp_log_header xp_out, x_title
    x_ex .each { xp_out "  ${it}" }
  }
  __gav_was_exit_processed = false
  gp_request_exit = { final long x_ec, final x_ex = [] ->
    def pp2_before_exit = {
      if (x_ex) gp_log_exception "Following error occurs !!!", x_ex
      if ( x_ec != GC_EC_SUCCESS && !x_ex ) { gp_log_header ( GC_LOG.&error, "Unknown error occurs !!!" ); }
      switch (x_ec) {
        case GC_EC_NONE : GC_LOG .error "Undefined exit code (GC_EC_NONE), check your logic !!!"; break
        case GC_EC_SHUTDOWN : GC_LOG .info "Exit code from shutdown like ctrl+c, ..."; break
        default :
          if ( x_ec < 0 ) GC_LOG .error "Negative exit code ${x_ec}, should consider using a positive value !!!"
          else GC_LOG .info "Exit code => ${x_ec}"
          break
      }
      GC_LOG .info "Elapsed ${ ( new Date () .getTime () - GC_ST .getTime () ) / 1000.0 } ..."
    }
    def pp2_exit = {
      switch (x_ec) {
        case GC_EC_NONE : System .exit (GC_EC_ERROR); break
        case GC_EC_SHUTDOWN : break
        default :
          if ( x_ec < 0 ) System .exit (GC_EC_ERROR)
          else System .exit ( x_ec .intValue () )
          break
      }
    }
    if ( __gav_was_exit_processed ) return
    pp2_before_exit ()
    __gav_was_exit_processed = true
    pp2_exit ()
  }
  addShutdownHook { gp_request_exit GC_EC_SHUTDOWN, [ 'Shutdown occurred !!!' ] }
JASH_EOS

JC_LOG = jy_ge 'GC_LOG'
def jp_set_log_level_to_info;  jy_gf 'gp_set_log_level_to_info';  end
def jp_set_log_level_to_warn;  jy_gf 'gp_set_log_level_to_warn';  end
def jp_set_log_level_to_debug; jy_gf 'gp_set_log_level_to_debug'; end
def jp_set_log_level_to_trace; jy_gf 'gp_set_log_level_to_trace'; end
def jp_log_error x_str; JC_LOG .error x_str; end
def jp_log_info  x_str; JC_LOG .info  x_str; end
def jp_log_warn  x_str; JC_LOG .warn  x_str; end
def jp_log_debug x_str; JC_LOG .debug x_str; end
def jp_log_trace x_str; JC_LOG .trace x_str; end
def jp_log_array xp_out = ( method :jp_log_info ), x_title, x_array
  return if x_array.empty?
  xp_out .call "#{x_title} =>"
  x_array .each .with_index (1) { | bx2_it, bx2_idx | xp_out .call "  #{'%2d' % bx2_idx} : #{bx2_it}" }
end
def jp_log_header xp_out = ( method :jp_log_info ), x_header, x_line_width
  xp_out .call '+' + '-' * x_line_width
  xp_out .call ": #{x_header}"
  xp_out .call '+' + '-' * x_line_width
end
def jp_request_exit x_ec, x_ex = nil
  jp_log_array ( method :jp_log_debug ), '$LOAD_PATH', $: .sort
  pu_ex_list = if x_ex
    bu2_ex_list = [x_ex.message]
    x_ex .backtrace .each { |bx2_it| bu2_ex_list << bx2_it }
    bu2_ex_list
  else
    x_ex
  end
  jy_gf 'gp_request_exit', x_ec, pu_ex_list
end

jy_ge ( 'gp_sr = { final Closure xp_it -> javax.swing.SwingUtilities .invokeLater { xp_it () } }' )
jy_ge <<-JASH_EOS.unindent
  gp_xr = { final Closure xp_it -> javafx.application.Platform .runLater { xp_it () } }
  class CgFxApp extends javafx.application.Application {
    private static Closure __casp_start
    static void csn_launch ( final Closure xp_it ) { __casp_start = xp_it; launch this }
    void start ( final javafx.stage.Stage x_stage ) { __casp_start ( this, x_stage ) }
  }
  Object.metaClass.gf_new_scene = { final Closure xp_it -> new javafx.embed.swing.JFXPanel () .with { xp_it () } }
JASH_EOS
JC_GR .put 'GC_IR', ( Rjb::bind (
  Class.new do
    def in_it x_bi, x_nethod_nm, x_args
      gp_bn x_bi, x_nethod_nm, *x_args
    end
  end.new
), 'IgIR' )
jy_ge <<-JASH_EOS.unindent
  import com.trolltech.qt.core.QObject
  Object.metaClass.gp_qr = { final Closure xp_it -> com.trolltech.qt.core.QCoreApplication.invokeLater { xp_it () } }
  class __CgQtSlot0 extends QObject {
    private Closure __cap_it = null
    __CgQtSlot0 ( final Closure xp_it ) { __cap_it = xp_it }
    void con_it () { __cap_it () }
  }
  class __CgQtSlot1 extends QObject {
    private Closure __cap_it = null
    __CgQtSlot1 ( final Closure xp_it ) { __cap_it = xp_it }
    void con_it (x_1) { __cap_it (x_1) }
  }
  class __CgQtSlot2 extends QObject {
    private Closure __cap_it = null
    __CgQtSlot2 ( final Closure xp_it ) { __cap_it = xp_it }
    void con_it ( x_1, x_2 ) { __cap_it ( x_1, x_2 ) }
  }
  class __CgQtSlot3 extends QObject {
    private Closure __cap_it = null
    __CgQtSlot3 ( final Closure xp_it ) { __cap_it = xp_it }
    void con_it ( x_1, x_2, x_3 ) { __cap_it ( x_1, x_2, x_3 ) }
  }
  class __CgQtSlot4 extends QObject {
    private Closure __cap_it = null
    __CgQtSlot4 ( final Closure xp_it ) { __cap_it = xp_it }
    void con_it ( x_1, x_2, x_3, x_4 ) { __cap_it ( x_1, x_2, x_3, x_4 ) }
  }
  class __CgQtSlot5 extends QObject {
    private Closure __cap_it = null
    __CgQtSlot5 ( final Closure xp_it ) { __cap_it = xp_it }
    void con_it ( x_1, x_2, x_3, x_4, x_5 ) { __cap_it ( x_1, x_2, x_3, x_4, x_5 ) }
  }
  class __CgQtSlot6 extends QObject {
    private Closure __cap_it = null
    __CgQtSlot6 ( final Closure xp_it ) { __cap_it = xp_it }
    void con_it ( x_1, x_2, x_3, x_4, x_5, x_6 ) { __cap_it ( x_1, x_2, x_3, x_4, x_5, x_6 ) }
  }
  class __CgQtSlot7 extends QObject {
    private Closure __cap_it = null
    __CgQtSlot7 ( final Closure xp_it ) { __cap_it = xp_it }
    void con_it ( x_1, x_2, x_3, x_4, x_5, x_6, x_7 ) { __cap_it ( x_1, x_2, x_3, x_4, x_5, x_6, x_7 ) }
  }
  class __CgQtSlot8 extends QObject {
    private Closure __cap_it = null
    __CgQtSlot8 ( final Closure xp_it ) { __cap_it = xp_it }
    void con_it ( x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8 ) { __cap_it ( x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8 ) }
  }
  class __CgQtSlot9 extends QObject {
    private Closure __cap_it = null
    __CgQtSlot9 ( final Closure xp_it ) { __cap_it = xp_it }
    void con_it ( x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9 ) { __cap_it ( x_1, x_2, x_3, x_4, x_5, x_6, x_7, x_8, x_9 ) }
  }
  def gf_qs0 ( final Closure xp_it ) { final fu_it = new __CgQtSlot0 (xp_it); return [ fu_it, 'con_it()' ] }
  def gf_qs1 ( final Closure xp_it ) { final fu_it = new __CgQtSlot1 (xp_it); return [ fu_it, 'con_it(Object)' ] }
  def gf_qs2 ( final Closure xp_it ) { final fu_it = new __CgQtSlot2 (xp_it); return [ fu_it, 'con_it(Object,Object)' ] }
  def gf_qs3 ( final Closure xp_it ) { final fu_it = new __CgQtSlot3 (xp_it); return [ fu_it, 'con_it(Object,Object,Object)' ] }
  def gf_qs4 ( final Closure xp_it ) { final fu_it = new __CgQtSlot4 (xp_it); return [ fu_it, 'con_it(Object,Object,Object,Object)' ] }
  def gf_qs5 ( final Closure xp_it ) { final fu_it = new __CgQtSlot5 (xp_it); return [ fu_it, 'con_it(Object,Object,Object,Object,Object)' ] }
  def gf_qs6 ( final Closure xp_it ) { final fu_it = new __CgQtSlot6 (xp_it); return [ fu_it, 'con_it(Object,Object,Object,Object,Object,Object)' ] }
  def gf_qs7 ( final Closure xp_it ) { final fu_it = new __CgQtSlot7 (xp_it); return [ fu_it, 'con_it(Object,Object,Object,Object,Object,Object,Object)' ] }
  def gf_qs8 ( final Closure xp_it ) { final fu_it = new __CgQtSlot8 (xp_it); return [ fu_it, 'con_it(Object,Object,Object,Object,Object,Object,Object,Object)' ] }
  def gf_qs9 ( final Closure xp_it ) { final fu_it = new __CgQtSlot9 (xp_it); return [ fu_it, 'con_it(Object,Object,Object,Object,Object,Object,Object,Object,Object)' ] }
  gf_qs = { final Closure xp_it -> return ( "gf_qs${ xp_it.parameterTypes.length }" (xp_it) ) }
JASH_EOS
jy_ge <<-JASH_EOS.unindent
  gp_bn = { final long x_bi, final String x_nethod_nm, final Object... x_args ->
    gp_qr { GC_IR .in_it ( x_bi, x_nethod_nm, *x_args ) }
  }
  Object.metaClass.gp_bn = gp_bn
JASH_EOS

#
# Main Skeleton
#

module DRun
  @__dav_ec = GC_EC_NONE
  @__dav_ex = nil
  def self.dp_it
    __dap_begin
    DBody .dp_it
    @__dav_ec = GC_EC_SUCCESS
  rescue Exception => bu2_ex
    @__dav_ec = GC_EC_ERROR
    @__dav_ex = bu2_ex
  ensure
    jp_request_exit @__dav_ec, @__dav_ex
  end
private
  def self.__dap_begin
    jp_puts gf_banner.join "\n"
    JC_LOG .debug "Pyja name => #{GC_PYJA_NM}"
    raise RuntimeError, 'Invalid Pyja name !!!' if GC_PYJA_NM != ( gf_os_env :SC_PYJA_NM )
    JC_LOG .debug "Pyja creation date => #{GC_PYJA_CD}"
    raise RuntimeError, 'Pyja create date is not invalid !!!' unless gf_str_is_valid_date GC_PYJA_CD, '%Y.%m.%d'
    JC_LOG .debug "Pyja version => #{GC_PYJA_V2}"
    raise RuntimeError, 'Invalid Pyja version !!!' if GC_PYJA_VR != ( gf_os_env :SC_PYJA_VR )
    JC_LOG .info  "Pyja root (#{GC_PYJA_RT_SYM}) => #{GC_PYJA_RT}"
    JC_LOG .info  "Pyja home (#{GC_PYJA_HM_SYM}) => #{ gf_to_prs GC_PYJA_HM }"
    JC_LOG .info  "Milo path (#{GC_MILO_PN_SYM}) => #{ gf_to_phs GC_MILO_PN }"
    JC_LOG .info  "Java home => #{GC_JAVA_HM}"
    JC_LOG .debug "Java version => #{JC_JAVA_VR}"
    JC_LOG .info  "Groovy jar file => #{ gf_to_phs JC_GROOVY_JAR_FN }"
    JC_LOG .debug "Groovy version => #{JC_GROOVY_VR}"
    JC_LOG .info  "QtJambi jar file => #{ gf_to_phs JC_QTJ_JAR_FN }"
    JC_LOG .debug "QtJambi version => #{JC_QTJ_VR}"
    JC_LOG .info  "Ruby home => #{GC_RUBY_HM}"
    JC_LOG .debug "Ruby version => #{GC_RUBY_VR}"
    JC_LOG .debug "Total CPU => #{GC_TOTAL_CPU}"
    JC_LOG .debug "Computer name => #{GC_HOST_NM}"
    JC_LOG .debug "Current user => #{GC_CUSR}"
    JC_LOG .debug "Process ID => #{GC_THIS_PID}"
    JC_LOG .info  "Start up path => #{ gf_to_phs GC_THIS_START_UP_PN }"
    JC_LOG .info  "Script file => #{ gf_to_phs GC_SCRIPT_FN }"
    jp_log_array  ( method :jp_log_debug ), 'Paths', GC_OS_ENV_PATHS
    jp_log_array  'Arguments', GC_ARGV if GC_ARGV.count > 0
  end
end

#
# Your Source
#

class HPerson
  class << self
    attr_reader :hsu_items
  end
  @hsu_items = jy_ge 'javafx.collections.FXCollections.observableArrayList ()'
  HIt = jy_ge """
    import groovy.transform.ToString
    import javafx.collections.ObservableList
    import javafx.beans.property.SimpleStringProperty
    @ToString ( includeNames = true )
    class HIt {
      final SimpleStringProperty hxu_first_nm
      final SimpleStringProperty hxu_last_nm
      final SimpleStringProperty hxu_email
      HIt ( final String x_first_nm, final String x_last_nm, final String x_email ) {
        hxu_first_nm = new SimpleStringProperty (x_first_nm)
        hxu_last_nm = new SimpleStringProperty (x_last_nm)
        hxu_email = new SimpleStringProperty (x_email)
      }
      def  getHu_first_nm () { return hxu_first_nm .get () }
      void setHu_first_nm ( final String x_it ) { hxu_first_nm .set x_it }
      def  getHu_last_nm () { return hxu_last_nm .get () }
      void setHu_last_nm ( final String x_it ) { hxu_last_nm .set x_it }
      def  getHu_email () { return hxu_email .get () }
      void setHu_email ( final String x_it ) { hxu_email .set x_it }
    }
  """
end

CFxFont = jf_jcls 'javafx.scene.text.Font'
CFxInsets = jf_jcls 'javafx.geometry.Insets'
CFxPos = jf_jcls 'javafx.geometry.Pos'
CFxPropertyValueFactory = jf_jcls 'javafx.scene.control.cell.PropertyValueFactory'

class WAddressBook
  def initialize; wn_init; end
  def wn_init
    @wu_bi = gf_bi self
    jy_ge """
      import javafx.scene.control.Button
      import javafx.scene.control.cell.TextFieldTableCell
      import javafx.scene.control.Label
      import javafx.scene.control.TableColumn
      import javafx.scene.control.TableView
      import javafx.scene.control.TextField
      import javafx.scene.layout.HBox
      import javafx.scene.layout.Priority
      import javafx.scene.layout.StackPane
      import javafx.scene.layout.VBox
      import javafx.scene.Scene
      import javafx.stage.Stage
      class WIt {
        final wu_bi = #{@wu_bi}
        final wu_app
        final wu_stage
        final wu_root = new StackPane ()
        final wu_lb = new Label ()
        final wu_tv = new TableView ()
        final wu_tc_first_nm = new TableColumn ()
        final wu_tc_last_nm = new TableColumn ()
        final wu_tc_email = new TableColumn ()
        final wu_vb = new VBox ()
        final wu_hb = new HBox ()
        final wu_tf_first_nm = new TextField ()
        final wu_tf_last_nm = new TextField ()
        final wu_tf_email = new TextField ()
        final wu_bn_add = new Button ()
        WIt ( final x_app, final x_stage ) {
          wu_app = x_app
          wu_stage = x_stage
          wn_init ()
        }
        def wn_init () {
          wu_tv .columnResizePolicy = TableView.CONSTRAINED_RESIZE_POLICY
          wu_vb .setVgrow wu_tv, Priority.ALWAYS
          [ wu_tc_first_nm, wu_tc_last_nm, wu_tc_email ] .each { it.cellFactory = TextFieldTableCell .forTableColumn () }
          wu_bn_add .with {
            text = 'Add'
            onAction = { gp_bn wu_bi, 'wn_add' }
          }
          wu_stage .with {
            title = GC_APP_NM
            wu_root .children .addAll wu_vb
            scene = gf_new_scene { new Scene ( wu_root, 460, 570 ) }
            onCloseRequest = { gp_bn wu_bi, 'wn_quit' }
          }
          gp_bn wu_bi, 'wn_fx_start', this
        }
      }
      Thread .start { CgFxApp .csn_launch { x_app, x_stage -> new WIt ( x_app, x_stage ) } }
    """
  end
  def wn_fx_start x_it
    @wu_it = x_it
    [
      [ 'Jacob', 'Smith', 'jacob.smith@example.com' ],
      [ 'Isabella', 'Johnson', 'isabella.johnson@example.com' ],
      [ 'Ethan', 'Williams', 'ethan.williams@example.com' ],
      [ 'Emma', 'Jones', 'emma.jones@example.com' ],
      [ 'Michael', 'Brown', 'michael.brown@example.com' ],
    ] .each { |bx2_it| HPerson.hsu_items .add HPerson::HIt.new *bx2_it }
    @wu_it.wu_tc_first_nm .tap { |it|
      it .setText 'First Name'
      it .setMinWidth 100
      it .setCellValueFactory CFxPropertyValueFactory.new 'hu_first_nm'
    }
    @wu_it.wu_tc_last_nm .tap { |it|
      it .setText 'Last Name'
      it .setMinWidth 100
      it .setCellValueFactory CFxPropertyValueFactory.new 'hu_last_nm'
    }
    @wu_it.wu_tc_email .tap { |it|
      it .setText 'EMail'
      it .setMinWidth 200
      it .setCellValueFactory CFxPropertyValueFactory.new 'hu_email'
    }
    [ [ @wu_it.wu_tc_first_nm, 'hu_first_nm' ], [ @wu_it.wu_tc_last_nm, 'hu_last_nm' ], [ @wu_it.wu_tc_email, 'hu_email' ] ] .each { | bx2_tc, bx2_attr_nm |
      jy_gc """{ x_tc -> 
        x_tc .onEditCommit = { x2_ev ->
          final pu2_o = x2_ev.tableView.items .get (x2_ev.tablePosition.row)
          pu2_o.#{bx2_attr_nm} = x2_ev.newValue
          GC_LOG .info 'onEditCommit => ' + pu2_o.toString ()
        }
      }""", bx2_tc
    }
    @wu_it.wu_lb .tap { |it|
      it .setText 'Address Book'
      it .setFont CFxFont.new 'Arial', 13.5
    }
    @wu_it.wu_tv .tap { |it| 
      it .setEditable true
      it .getColumns .addAll [ @wu_it.wu_tc_first_nm, @wu_it.wu_tc_last_nm, @wu_it.wu_tc_email ]
      it .setItems HPerson.hsu_items
    }
    @wu_it.wu_tf_first_nm .tap { |it| 
      it .setPromptText 'First Name'
      it .setMaxWidth @wu_it.wu_tc_first_nm .getPrefWidth
    }
    @wu_it.wu_tf_last_nm .tap { |it| 
      it .setPromptText 'Last Name'
      it .setMaxWidth @wu_it.wu_tc_last_nm .getPrefWidth
    }
    @wu_it.wu_tf_email .tap { |it| 
      it .setPromptText 'Email'
      it .setMaxWidth @wu_it.wu_tc_email .getPrefWidth
    }
    @wu_it.wu_hb .tap { |it| 
      it .setSpacing 3
      it .setAlignment CFxPos.CENTER
      it .getChildren .addAll [ @wu_it.wu_tf_first_nm, @wu_it.wu_tf_last_nm, @wu_it.wu_tf_email, @wu_it.wu_bn_add ]
    }
    @wu_it.wu_vb .tap { |it| 
      it .setSpacing 5
      it .setPadding CFxInsets.new 10
      it .setAlignment CFxPos.CENTER
      it .getChildren .addAll [ @wu_it.wu_lb, @wu_it.wu_tv, @wu_it.wu_hb ]
    }
    jy_gc '{ x_stage -> gp_xr { x_stage .show () } }', @wu_it.wu_stage
  end
  def wn_add
    nu_tfs = [ @wu_it.wu_tf_first_nm, @wu_it.wu_tf_last_nm ,@wu_it.wu_tf_email ]
    HPerson.hsu_items .add HPerson::HIt.new *( nu_tfs .map { |it| it .getText } )
    nu_tfs .each { |it| it .clear }
  end
  def wn_quit
    JC_QAPP .quit
  end
end

module DBody
  def self.dp_it
    JC_QAPP .initialize []
    jf_jcls('com.trolltech.qt.gui.QWidget').new.tap { |it| it .show; it .raise; it .close } if CjPlatform .isMac # for bringing widget to the front in macOS
    pu_main = WAddressBook .new
    JC_QAPP .execStatic
  end
end

module OStart
  def self.main
    jp_set_log_level_to_info
    DRun .dp_it
  end
end

if $0 == __FILE__
  OStart.main
end
