#
# Ruby (Global)
#

GC_ST = Time.now

GC_PYJA_NM = 'Pyja'
GC_PYJA_AU = 'Erskell' # (au)thor

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
GC_EC_SHUTDOWN = 130
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
    "made by #{GC_PYJA_AU}",
    '',
    "ran on #{ GC_ST .strftime ('%F %T') }",
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

def gf_yi x_yo; x_yo.object_id; end # yi => rub(y) (i)d, yo => rub(y) (o)bject

$__DgLongLiveObjects = Module.new {
  @__dau_it = {}
  def self.df_cllo ( x_it, *x_args ) # cllo -> (c)reate (l)ong (l)ive (o)bject
    fu_yo = ( x_it.class == Class ) ? ( x_it.new *x_args ) : x_it
    fu_yi = gf_yi fu_yo
    @__dau_it [fu_yi] = fu_yo
    return fu_yi
  end
  def self.dp_dllo (x_yi) # dllo -> (d)estroy (l)ong (l)ive (o)bject
    @__dau_it .delete x_yi
  end
  def self.df_it; @__dau_it; end
}
def gf_cllo x_it, *x_args; $__DgLongLiveObjects .df_cllo x_it, *x_args; end
def gp_dllo x_yi; $__DgLongLiveObjects .dp_dllo x_yi; end
def gf_llos; $__DgLongLiveObjects .df_it; end

def gf_yo x_yi, x_dllo = false # rub(y) (o)bject
  fu_it = ObjectSpace._id2ref x_yi
  gp_dllo x_yi if x_dllo
  return fu_it
end

def gp_yn x_yi, x_nethod_nm, *x_args # from rub(y) (i)d, call rub(y) (n)ethod
  pu_yo = gf_yo (x_yi)
  pu_yo.send x_nethod_nm, *x_args if pu_yo .respond_to? x_nethod_nm, true
end
def gf_ym x_yi, x_nethod_nm, *x_args # from rub(y) (i)d, call rub(y) (m)ethod
  pu_yo = gf_yo (x_yi)
  return pu_yo.send x_nethod_nm, *x_args if pu_yo .respond_to? x_nethod_nm, true
end

$__CgYethod = Class.new {
  def initialize x_oj, x_yethod_sym
    @__cau_oj = x_oj
    @__cau_yethod_sym = x_yethod_sym
  end
  def cy_call *x_args
    @__cau_oj .send @__cau_yethod_sym, *x_args
  end
}
def gf_yy x_oj, x_yethod_sym # rub(y) (y)ethod
  $__CgYethod.new x_oj, x_yethod_sym
end

LgCx = ( Struct.new :lu_ec, :lu_ex )

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
def jy_ge x_str
  JC_GR .eval x_str
rescue Exception => bu2_ex
  puts '+' + '-' * 60
  puts ': Error occurs during evaluation of groovy script !!!!'
  puts '+' + '-' * 60
  puts "#{bu2_ex}"
  exit GC_EC_ERROR
end
def jy_gf x_nm, *x_args; JC_GR. invokeFunction x_nm, x_args; end
def jy_gm x_oj, x_nm, *x_args; JC_GR. invokeMethod x_oj, x_nm, x_args; end
def jy_gc x_closure, *x_args
  yu_closure = x_closure.kind_of?(String) ? jy_ge(x_closure) : x_closure
  jy_gm yu_closure, 'call', *x_args
end
JC_GROOVY_VR = ( jy_ge 'GroovySystem.version' ) .toString
JC_QTJ_VR = ( jy_ge 'com.trolltech.qt.QtInfo .versionString ()' ) .toString

jy_ge <<-__JASH_EOS.unindent
  GC_APP_NM      = '#{GC_APP_NM}'
  GC_EC_NONE     = #{GC_EC_NONE}
  GC_EC_SHUTDOWN = #{GC_EC_SHUTDOWN}
  GC_EC_SUCCESS  = #{GC_EC_SUCCESS}
  GC_EC_ERROR    = #{GC_EC_ERROR}
  GC_THIS_PID    = #{GC_THIS_PID}
__JASH_EOS

jy_ge <<-__JASH_EOS.unindent
  gp_puts = { final x_str -> println x_str }
  gf_is_instance = { final x_cls, final x_oj -> x_cls .isInstance (x_oj) }
  gp_add_jar = { final String x_jar_fn ->
    if ( ! new File (x_jar_fn) .exists () ) { throw new FileNotFoundException ( "JAR file not found => ${x_jar_fn}" ) }
    final URL pu_url = new File (x_jar_fn) .toURI () .toURL ()
    final URLClassLoader pu_cl = ClassLoader .getSystemClassLoader ()
    final fu_m = URLClassLoader.class .getDeclaredMethod 'addURL', URL.class
    fu_m.setAccessible true
    fu_m.invoke pu_cl, pu_url
  }
  gp_sr = { final Closure xp_it -> // (S)wing (r)un
    javax.swing.SwingUtilities .invokeLater { xp_it () }
  } 
  gp_xr = { final Closure xp_it -> // JavaF(x) (r)un
    javafx.application.Platform .runLater { xp_it () }
  }
  gf_is_fat = { return javafx.application.Platform .isFxApplicationThread () }
  Object.metaClass.gp_sr = gp_sr
  Object.metaClass.gp_xr = gp_xr
  Object.metaClass.gf_is_fat = gf_is_fat
__JASH_EOS
def jp_puts x_str; jy_gf 'gp_puts', x_str; end
def jf_jcls x_cls_nm; Rjb::import x_cls_nm; end
def jf_is_instance x_cls, x_oj; ( jy_gf 'gf_is_instance', x_cls, x_oj ) .booleanValue; end
def jp_add_jar x_jar_fn; jy_gf 'gp_add_jar', x_jar_fn; end
def jf_gi x_cls; jy_ge "@groovy.transform.Immutable #{x_cls}";end # (g)roovy (i)mmutable class
def jf_al_to_a x_al, x_mn_sym; ( 0 ... x_al .size ) .map { |bx2_idx| ( x_al .get bx2_idx ) .send x_mn_sym } ; end # java.util.ArrayList to array

CjBigInteger = jf_jcls 'java.math.BigInteger'
CjBoolean    = jf_jcls 'java.lang.Boolean'
CjByte       = jf_jcls 'java.lang.Byte'
CjChar       = jf_jcls 'java.lang.Character'
CjDouble     = jf_jcls 'java.lang.Double'
CjFloat      = jf_jcls 'java.lang.Float'
CjInteger    = jf_jcls 'java.lang.Integer'
CjLong       = jf_jcls 'java.lang.Long'
CjShort      = jf_jcls 'java.lang.Short'
CjString     = jf_jcls 'java.lang.String'
CjSystem     = jf_jcls 'java.lang.System'

JC_QAPP = jf_jcls 'com.trolltech.qt.gui.QApplication'
JC_GR .put 'GC_QAPP', JC_QAPP
JC_QAPP .initialize []

JC_JAVA_VR = CjSystem .getProperty 'java.version'

[ 
  ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'akka-actor_2.12-2.5.9.jar' ),
  ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'akka-slf4j_2.12-2.5.9.jar' ),
  ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'config-1.3.2.jar' ),
  ( gf_pj GC_PYJA_HM, 'Library', 'Akka', '2.5.9', 'scala-library.jar' ),
  ( gf_pj GC_PYJA_HM, 'Library', 'JNA', '4.5.1', 'jna-4.5.1.jar' ),
  ( gf_pj GC_PYJA_HM, 'Library', 'JNA', '4.5.1', 'jna-platform-4.5.1.jar' ),
  ( gf_pj GC_PYJA_HM, 'Library', 'Logback', '1.2.3', 'logback-classic-1.2.3.jar' ),
  ( gf_pj GC_PYJA_HM, 'Library', 'Logback', '1.2.3', 'logback-core-1.2.3.jar' ),
  ( gf_pj GC_PYJA_HM, 'Library', 'SLF4J', '1.7.25', 'slf4j-api-1.7.25.jar' ),
] .each { |bu2_jar_fn| jp_add_jar bu2_jar_fn }

CjAwait    = jf_jcls 'scala.concurrent.Await'
CjDuration = jf_jcls 'scala.concurrent.duration.Duration'
CjPatterns = jf_jcls 'akka.pattern.Patterns'
CjPlatform = jf_jcls 'com.sun.jna.Platform'
CjTimeout  = jf_jcls 'akka.util.Timeout'

jy_ge <<-__JASH_EOS.unindent
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
  Object.metaClass.GC_LOG = GC_LOG
  Object.metaClass.gp_log_array = gp_log_array
  Object.metaClass.gp_log_header = gp_log_header
  Object.metaClass.gp_log_exception = gp_log_exception
__JASH_EOS
JC_LOG = jy_ge 'GC_LOG'
def jp_set_log_level_to_info;  jy_gf 'gp_set_log_level_to_info';  end
def jp_set_log_level_to_warn;  jy_gf 'gp_set_log_level_to_warn';  end
def jp_set_log_level_to_debug; jy_gf 'gp_set_log_level_to_debug'; end
def jp_set_log_level_to_trace; jy_gf 'gp_set_log_level_to_trace'; end
def jp_log_array xp_out = ( gf_yy JC_LOG, :info ), x_title, x_array
  return if x_array.empty?
  xp_out .cy_call "#{x_title} =>"
  x_array .each .with_index (1) { | bx2_it, bx2_idx | xp_out .cy_call "  #{'%2d' % bx2_idx} : #{bx2_it}" }
end
def jp_log_header xp_out = ( gf_yy JC_LOG, :info ), x_header, x_line_width
  xp_out .cy_call '+' + '-' * x_line_width
  xp_out .cy_call ": #{x_header}"
  xp_out .cy_call '+' + '-' * x_line_width
end
def jp_log_exception xp_out = ( gf_yy JC_LOG, :error ), x_title, x_ex
  jp_log_header xp_out, x_title, 60
  xp_out .cy_call x_ex.message
  x_ex .backtrace .each { |bx2_it| xp_out .cy_call "  #{bx2_it}" } unless x_ex .backtrace .nil?
end

JC_GR .put 'GC_IR', ( Rjb::bind (
  Class.new do
    def in_it x_yi, x_nethod_nm, x_args
      gp_yn x_yi, x_nethod_nm, *x_args
    end
  end.new
), 'IgIR' )
jy_ge <<-__JASH_EOS.unindent
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
__JASH_EOS
jy_ge <<-__JASH_EOS.unindent
  GC_YI_OBJECT = #{ gf_yi Object }
  gp_yn = { final long x_yi, final String x_nethod_nm, final Object... x_args ->
    gp_qr { GC_IR .in_it ( x_yi, x_nethod_nm, *x_args ) }
  }
  gp_cy = { final String x_nethod_nm, final Object... x_args ->
    gp_qr { GC_IR .in_it ( GC_YI_OBJECT, x_nethod_nm, *x_args ) }
  }
  Object.metaClass.gp_yn = gp_yn
  Object.metaClass.gp_cy = gp_cy
__JASH_EOS

def jp_os_exit x_ec
  JC_LOG.info "Elapsed #{ ( Time.at Time.now - GC_ST ) .utc .strftime ('%H:%M:%S.%L') } ..."
  CjSystem .exit x_ec
end

$__DjExit = Module.new {
  @__dav_cx = LgCx.new GC_EC_NONE, nil
  @__dav_was_lgcx_processed = false
  def self.dp_it x_cx
    ( jf_jcls 'javafx.application.Platform' ) .exit
    JC_LOG .debug "Received LgCx #{x_cx.lu_ec}"
    unless @__dav_was_lgcx_processed
      @__dav_was_lgcx_processed = true
      @__dav_cx = x_cx

      if Object.const_defined? 'JC_AS'
        JC_LOG .debug 'Terminating JC_AS ...'
        JC_AS .terminate
        CjAwait .ready JC_AS .when_terminated, CjDuration.Inf
      end
      __dap_before_exit
      __dap_exit
    end
  end
private
  def self.__dap_before_exit
    pu_ec = @__dav_cx.lu_ec
    jp_log_array ( gf_yy JC_LOG, :debug ), '$LOAD_PATH', $: .sort unless pu_ec == GC_EC_SUCCESS
    pu_ex = @__dav_cx.lu_ex
    jp_log_exception 'Following error occurs !!!', pu_ex unless pu_ex .nil?
    jp_log_header ( gf_yy JC_LOG, :error ), 'Unknown error occurs !!!', 60 if pu_ec != GC_EC_SUCCESS and pu_ex .nil?
    case
    when pu_ec == GC_EC_NONE then JC_LOG .error 'Undefined exit code (GC_EC_NONE), check your logic !!!'
    when pu_ec == GC_EC_SHUTDOWN then JC_LOG .info 'Exit code from shutdown like ctrl+c, ...'
    when pu_ec < 0 then JC_LOG .error "Negative exit code (#{pu_ec}), should consider using a positive value !!!"
    else JC_LOG .info "Exit code => #{pu_ec}"
    end
  end
  def self.__dap_exit
    pu_ec = @__dav_cx.lu_ec
    case
    when pu_ec == GC_EC_NONE then jp_os_exit GC_EC_ERROR
    when pu_ec == GC_EC_SHUTDOWN then jp_os_exit GC_EC_SHUTDOWN
    when pu_ec < 0 then jp_os_exit GC_EC_ERROR
    else jp_os_exit pu_ec
    end
  end
}
def jp_request_exit x_ec, x_ex = nil
  $__DjExit .dp_it LgCx.new x_ec, x_ex
end

jy_ge <<-__JASH_EOS.unindent
  class CgAt extends akka.actor.AbstractActor { // (A)c(t)or
    final private long __cau_yi_at
    CgAt ( final long x_yi_at ) {
      this.__cau_yi_at = x_yi_at
      gp_yn ( this.__cau_yi_at, 'cn_create', this )
    }
    void preStart () {
      gp_yn ( this.__cau_yi_at, 'cn_pre_start' )
    }
    akka.actor.AbstractActor.Receive createReceive () {
      return receiveBuilder () .match ( Object.class, { x_letter ->
        final pu_sender = getSender ()
        gp_yn ( this.__cau_yi_at, 'cn_receive', x_letter, pu_sender )
      } ) .build ()
    }
    void postStop () {
      gp_yn ( this.__cau_yi_at, 'cn_post_stop' )
    }
  }
  gf_mk_atr = { final long x_yi_at, final String x_at_nm, final akka.actor.ActorRefFactory x_arf -> // atr -> (a)c(t)or (r)eference
    switch (x_at_nm) {
      case ':a' : return x_arf .actorOf ( akka.actor.Props .create ( CgAt, x_yi_at ) )
      default : return x_arf .actorOf ( akka.actor.Props .create ( CgAt, x_yi_at ), x_at_nm )
    }
  }
__JASH_EOS
class CjAt
  def initialize
    @cu_yi = gf_cllo self
  end
  def cn_create x_at_org
    @cu_at_org = x_at_org
    self .send 'create' if self .respond_to? 'create', true
  end
  def cn_pre_start
    self .send 'preStart' if self .respond_to? 'preStart', true
  end
  def cn_receive x_letter, x_atr_sender
    self .send 'receive', x_letter, x_atr_sender if self .respond_to? 'receive', true
  end
  def cn_post_stop
    self .send 'postStop' if self .respond_to? 'postStop', true
    gf_yo @cu_yi, true
  end
  def getSelf; @cu_at_org .getSelf; end
  def getContext; @cu_at_org .getContext; end
  def tell x_atr_target, x_letter, x_atr_sender = nil
    nu_atr_sender = x_atr_sender.nil? ? getSelf : x_atr_sender
    x_atr_target .tell x_letter, nu_atr_sender
  end
end
def jf_mk_atr x_at, x_at_nm, x_arf = nil
  unless Object.const_defined? 'JC_AS'
    gp_set_const :JC_AS, ( jy_ge "Object.metaClass.%<nm>s = akka.actor.ActorSystem .create '%<nm>s', com.typesafe.config.ConfigFactory .parseString ( 'akka { loglevel = \"ERROR\" }' )" % { nm: 'GC_AS' } )
  end
  fu_arf = x_arf.nil? ? JC_AS : x_arf
  fu_at_nm = x_at_nm == :c ? x_at.class.name : ( x_at_nm.nil? ? ':a' : x_at_nm )
  return jy_gf 'gf_mk_atr', ( gf_yi x_at ), fu_at_nm, fu_arf
end

def jp_to_front_if_is_mac
  jf_jcls('com.trolltech.qt.gui.QMainWindow').new.tap { |it| it .resize 1, 1; it .show; it .raise; it .close } if CjPlatform .isMac # for bringing widget to the front in macOS
end

jy_ge <<-__JASH_EOS.unindent
  import javafx.stage.Stage
  class __CgFxApp extends javafx.application.Application {
    private static Closure __casp_start
    private static long __casl_yi
    private static String __casl_yo_nethod_nm
    static void csn_launch ( final Closure xp_it, final long x_yi, final String x_yo_nethod_nm ) {
      __casp_start = xp_it
      __casl_yi = x_yi
      __casl_yo_nethod_nm = x_yo_nethod_nm
      launch this
    }
    void start ( final Stage x_stage ) { __casp_start ( __casl_yi, __casl_yo_nethod_nm, x_stage ) }
  }
  __gap_fx_start = { final long x_yi, final String x_yo_nethod_nm, final Stage x_stage -> gp_yn x_yi, x_yo_nethod_nm, x_stage }
  gp_fx_start = { final long x_yi, final String x_yo_nethod_nm -> Thread .start { __CgFxApp .csn_launch __gap_fx_start, x_yi, x_yo_nethod_nm } }
__JASH_EOS

module TjUtil
  def tn_qt_connect x_qt_signal, x_args, x_yo_nethod_nm
    nu_args = x_args.strip.empty? ? '' : ", #{x_args}"
    nu_qs = jy_ge "gf_qs { #{x_args} -> gp_yn #{@cu_yi}, '#{x_yo_nethod_nm}' #{nu_args} }"
    ( @tu_qs_llos ||= [] ) << nu_qs
    jy_gc "{ x_qt_signal, x_qs -> x_qt_signal .connect x_qs }", x_qt_signal, nu_qs
  end
  def tn_fx_start x_yo_nethod_nm
    jy_gf 'gp_fx_start', ( CjLong.new @cu_yi ), x_yo_nethod_nm
  end
  def tn_fx_set_eh x_xo, x_xo_eh_nm, x_yo_nethod_nm # xo -> F(x) (o)bject, eh -> fx (e)vent (h)andler
    jy_gc """{ x_xo ->
      x_xo.#{x_xo_eh_nm} = { x2_ev -> gp_yn #{@cu_yi}, '#{x_yo_nethod_nm}', x2_ev }
    }""", x_xo
  end
  def tn_fx_add_cl x_property, x_yo_nethod_nm # cl -> (c)hange (l)istener
    jy_gc """{ x_property ->
      x_property .addListener ( { x2_obs, x2_old, x2_new -> gp_yn #{@cu_yi}, '#{x_yo_nethod_nm}', x2_obs, x2_old, x2_new } as javafx.beans.value.ChangeListener )
    }""", x_property
  end
  def tn_ak_fut_oc x_future, x_yo_nethod_nm # ak -> (ak)ka, fut -> (fut)ure, oc -> (o)n(C)omplete
    jy_gc """{ x_future, x_dispatcher ->
      x_future .onComplete ( { x2_throwable, x2_result -> gp_xr { gp_yn #{@cu_yi}, '#{x_yo_nethod_nm}', x2_throwable, x2_result } } as akka.dispatch.OnComplete, x_dispatcher )
    }""", x_future, getContext.dispatcher
  end
end

#
# Main Skeleton
#

module DRun
  def self.dp_it
    __dap_begin
    DBody .dp_it
  rescue Exception => bu2_ex
    jp_request_exit GC_EC_ERROR, bu2_ex
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
    JC_LOG .info  "Java version => #{JC_JAVA_VR}"
    JC_LOG .info  "Groovy version => #{JC_GROOVY_VR}"
    JC_LOG .info  "QtJambi version => #{JC_QTJ_VR}"
    JC_LOG .info  "Ruby version => #{GC_RUBY_VR}"
    JC_LOG .info  "Total CPU => #{GC_TOTAL_CPU}"
    JC_LOG .debug "Computer name => #{GC_HOST_NM}"
    JC_LOG .debug "Current user => #{GC_CUSR}"
    JC_LOG .debug "Process ID => #{GC_THIS_PID}"
    JC_LOG .info  "Start up path => #{ gf_to_phs GC_THIS_START_UP_PN }"
    JC_LOG .info  "Script file => #{ gf_to_mps GC_SCRIPT_FN }"
    jp_log_array  ( gf_yy JC_LOG, :debug ), 'Paths', GC_OS_ENV_PATHS
    jp_log_array  'Arguments', GC_ARGV if GC_ARGV.count > 0
  end
end

#
# Your Source
#

QPlastiqueStyle = jf_jcls 'com.trolltech.qt.gui.QPlastiqueStyle'

class CAtFibonacci < CjAt
  def initialize
    super
    cn_init
  end
  def cn_init
    @cu_it = Hash.new{ | bx2_no, bx2_idx |
      bx2_no [bx2_idx] = @cu_it [ bx2_idx - 2 ] + @cu_it [ bx2_idx - 1 ]
    }.update( 0 => 0, 1 => 1 )
  end
  def receive x_letter, x_atr_sender
    nu_java_nm = x_letter._classname
    JC_LOG .trace "Received #{nu_java_nm}"
    case nu_java_nm
    when 'java.lang.Integer' then tell x_atr_sender, CjBigInteger.new( @cu_it [x_letter.int_value] .to_s )
    end
  end
end

class WAtMain < CjAt
  include TjUtil
  def initialize
    super
    tn_fx_start 'wn_init'
  end
  def wn_import_fx_classes
    gp_set_const :CjInsets, ( jf_jcls 'javafx.geometry.Insets' )
    gp_set_const :CjLabel, ( jf_jcls 'javafx.scene.control.Label' )
    gp_set_const :CjPos, ( jf_jcls 'javafx.geometry.Pos' )
    gp_set_const :CjSlider, ( jf_jcls 'javafx.scene.control.Slider' )
    gp_set_const :CjVBox, ( jf_jcls 'javafx.scene.layout.VBox' )
  end
  def wn_init x_stage
    JC_LOG .info 'Initializing ...'
    wn_import_fx_classes
    @wu_stage = x_stage
    @wu_atr_fibo = jf_mk_atr CAtFibonacci.new, :c
    @wu_timeout = CjTimeout.new CjDuration.create 3, 'seconds'
    @wu_lb_no = CjLabel.new
    nu_initial_no = 10
    wn_show_no nu_initial_no
    @wu_sldr_4_no = CjSlider.new .tap { |it|
      it.min = 0
      it.max = 360
      it.value = nu_initial_no
      it.show_tick_labels = true
      it.show_tick_marks = true
      it.block_increment = 10
      tn_fx_add_cl it .value_property, 'wn_cl_sldr_4_no_val'
    }
    @wu_lb_fibo = CjLabel.new 'Fibonacci :'
    @wu_lb_fibo_result = CjLabel.new
    @wu_root = CjVBox.new .tap { |it|
      it.alignment = CjPos.CENTER
      it.padding = CjInsets.new 20
      it.spacing = 10
      it.children .add_all [ @wu_lb_no, @wu_sldr_4_no, @wu_lb_fibo, @wu_lb_fibo_result ]
    }
    @wu_stage .tap { |it|
      it .setTitle GC_APP_NM
      it .setWidth 750
      it .setHeight 190
      tn_fx_set_eh it, 'onShown', 'wn_on_shown'
      tn_fx_set_eh it, 'onCloseRequest', 'wn_on_quit'
      jy_gc """{ x_stage, x_root ->
        gp_xr {
          x_stage .with {
            setScene ( new javafx.embed.swing.JFXPanel () .with { new javafx.scene.Scene (x_root) } )
            centerOnScreen ()
            show ()
            toFront ()
          }
        }
      }""", it, @wu_root
    }
  end
  def wn_show_no x_no
    jy_gc "{ x_lb_no, x_text -> gp_xr { x_lb_no.text = x_text } }", @wu_lb_no, "Number => #{x_no}"
  end
  def wn_ask_fibo
    nu_future = CjPatterns .ask @wu_atr_fibo, @wu_sldr_4_no.value.to_i, @wu_timeout
    tn_ak_fut_oc nu_future, 'wn_oc_fibo'
  end
  def wn_oc_fibo x_throwable, x_result
    if x_throwable.class == NilClass
      jy_gc "{ x_lb_fibo_result, x_text -> gp_xr { x_lb_fibo_result.text = x_text } }", @wu_lb_fibo_result, ( CjString.format '%,d', [x_result] )
    end
  end
  def wn_cl_sldr_4_no_val x_obs, x_old, x_new
    wn_show_no @wu_sldr_4_no.value.to_i
    wn_ask_fibo
  end
  def wn_on_shown x_ev
    JC_LOG .info 'Stage shown ...'
    @wu_scene = @wu_stage .getScene
    wn_ask_fibo
  end
  def wn_on_quit x_ev
    JC_LOG .info 'About to quit ...'
    jp_request_exit GC_EC_SUCCESS
  end
end

module DBody
  def self.dp_it
    JC_QAPP .setStyle QPlastiqueStyle.new
    jp_to_front_if_is_mac
    pu_atr_main = jf_mk_atr WAtMain.new, :c
    JC_QAPP .execStatic
  end
end

module OStart
  def self.main
    # jp_set_log_level_to_info
    # jp_set_log_level_to_trace
    DRun .dp_it
  end
end

if $0 == __FILE__
  OStart.main
end
