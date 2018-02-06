//
// Global
//

object Global {
  val GC_ST = System.currentTimeMillis

  val GC_PYJA_NM = "Pyja"

  val GC_PJYA_CEN = 20
  val GC_PYJA_YEA = 18
  val GC_PYJA_MON =  2
  val GC_PYJA_DAY =  1

  val GC_PYJA_CD = "%02d%02d.%02d.%02d" .format ( GC_PJYA_CEN, GC_PYJA_YEA, GC_PYJA_MON, GC_PYJA_DAY ) // Pyja creation date
  val GC_PYJA_VR = "%02d.%02d.%02d" .format ( GC_PYJA_YEA, GC_PYJA_MON, GC_PYJA_DAY )                  // Pyja version with fixed length 8
  val GC_PYJA_V2 = "%d.%d.%d" .format ( GC_PYJA_YEA, GC_PYJA_MON, GC_PYJA_DAY )                        // Pyja version without leading zero

  val GC_PYJA_VER_MAJ = GC_PYJA_YEA // Major
  val GC_PYJA_VER_MIN = GC_PYJA_MON // Minor
  val GC_PYJA_VER_PAT = GC_PYJA_DAY // Patch

  val GC_PYJA_RT_SYM = "@`"
  val GC_PYJA_HM_SYM = "@~"
  val GC_MILO_PN_SYM = "@!"

  val GC_EC_NONE     = -200
  val GC_EC_SHUTDOWN = -199
  val GC_EC_SUCCESS  = 0
  val GC_EC_ERROR    = 1

  com.trolltech.qt.gui.QApplication .initialize ( new Array [String] (0) )

  val GC_FOSA = java.io.File.separator     // (fo)lder (s)ep(a)rator
  val GC_PASA = java.io.File.pathSeparator // (pa)th (s)ep(a)rator

  val GC_TOTAL_CPU = Runtime.getRuntime.availableProcessors
  val GC_TOTAL_MEMORY = java.lang.management.ManagementFactory .getOperatingSystemMXBean .asInstanceOf [com.sun.management.OperatingSystemMXBean] .getTotalPhysicalMemorySize
  val GC_HOST_NM = com.trolltech.qt.network.QHostInfo.localHostName
  val GC_CUSR = gf_sys_props ("user.name")
  val GC_THIS_PID = com.trolltech.qt.core.QCoreApplication.applicationPid

  def gf_tap [O] ( x_it : O ) ( xnu_do : O => Unit ) : O = { xnu_do (x_it); x_it }
  def gf_os_env ( x_key : Symbol ) = sys.env (x_key.name)
  def gf_os_env ( x_key : String ) = sys.env (x_key)
  def gf_sys_props ( x_key : Symbol ) = sys.props (x_key.name)
  def gf_sys_props ( x_key : String ) = sys.props (x_key)
  def gf_str_is_valid_date ( x_str : String, x_format : String ) = {
    var fv_is_valid = true
    try { gf_tap ( new java.text.SimpleDateFormat (x_format) ) { it => it .setLenient (false); it .parse (x_str) } } catch { case _ : Exception => fv_is_valid = false }
    fv_is_valid
  }
  def gf_rm_px ( x_str : String, x_px : String ) = { // px : prefix
    if ( x_str.startsWith (x_px) ) x_str.replaceFirst ( s"^${x_px}", "" ) else x_str
  }

  val GC_OS_ENV_PATHS = gf_os_env ('SC_PATH) .split (GC_PASA)

  def gf_b2fs ( x_it : String ) = { x_it .replaceAll ( "\\\\", "/" ) } // replace backslash to forwardslash
  def gf_ap ( x_it : String, x_canonical : Boolean = true ) = { // absolute path
    val fu_fl = new java.io.File (x_it)
    gf_b2fs ( if (x_canonical) fu_fl .getCanonicalPath () else fu_fl .getAbsolutePath () )
  }
  def gf_bn ( x_fn : String ) = java.nio.file.Paths .get (x_fn) .getFileName () .toString () // base name
  def gf_jn ( x_fn : String ) = { // just name without extension
    val fu_bn = gf_bn (x_fn)
    fu_bn.substring ( 0, fu_bn .lastIndexOf (".") )
  }
  def gf_if ( x_fn : String ) = new java.io.File (x_fn) .isFile ()
  def gf_id ( x_pn : String ) = new java.io.File (x_pn) .isDirectory ()
  def gf_pj ( x_args : String* ) = { gf_b2fs ( x_args .mkString ("/") ) } // path join

  private var __gav_argv : Array [String] = _
  def gp_set_argv ( x_argv : Array [String] ) { __gav_argv = x_argv }
  lazy val GC_ARGV = __gav_argv

  val GC_PYJA_RT = gf_b2fs ( gf_os_env ('SC_PYJA_RT) )
  val GC_PYJA_HM = gf_b2fs ( gf_os_env ('SC_PYJA_HM) )
  val GC_JAVA_HM = gf_b2fs ( gf_os_env ('SC_J8_HM) )
  val GC_MILO_PN = gf_b2fs ( gf_os_env ('SC_MILO_PN) )
  val GC_USER_HM = gf_b2fs ( gf_sys_props ("user.home") )

  val GC_THIS_START_UP_PN = gf_ap (".")

  val GC_THIS_JAR_FN = gf_b2fs ( gf_sys_props ('SC_THIS_JAR_FN) )
  val GC_APP_NM = gf_jn (GC_THIS_JAR_FN)

  def gp_add_jar ( x_fn : String ) {
    if ( ! gf_if (x_fn) ) throw new java.io.FileNotFoundException ( s"Can't find jar file => ${x_fn}" )
    val pu_url = new java.io.File (x_fn) .toURI () .toURL ()
    val pu_cl = ClassLoader .getSystemClassLoader .asInstanceOf [java.net.URLClassLoader]
    val pu_m = classOf [java.net.URLClassLoader] .getDeclaredMethod ( "addURL", classOf [java.net.URL] )
    pu_m .setAccessible (true)
    pu_m .invoke ( pu_cl, pu_url )
  }

  List (
    // jar*
    gf_pj ( GC_PYJA_HM, "Library", "Akka", "2.5.9", "akka-actor_2.12-2.5.9.jar" ),
    gf_pj ( GC_PYJA_HM, "Library", "Akka", "2.5.9", "akka-slf4j_2.12-2.5.9.jar" ),
    gf_pj ( GC_PYJA_HM, "Library", "Akka", "2.5.9", "config-1.3.2.jar" ),
    gf_pj ( GC_PYJA_HM, "Library", "Logback", "1.2.3", "logback-classic-1.2.3.jar" ),
    gf_pj ( GC_PYJA_HM, "Library", "Logback", "1.2.3", "logback-core-1.2.3.jar" ),
    gf_pj ( GC_PYJA_HM, "Library", "ReactiveStreams", "1.0.2", "reactive-streams-1.0.2.jar" ),
    gf_pj ( GC_PYJA_HM, "Library", "SLF4J", "1.7.25", "slf4j-api-1.7.25.jar" ),
    gf_pj ( GC_PYJA_HM, "Library", "Slick", "3.2.1", "slick_2.12-3.2.1.jar" ),
    // *raj
  ) .foreach { bx2_jar_fn => gp_add_jar (bx2_jar_fn) }

  private object __DgPrivate {
    lazy val du_lc = org.slf4j.LoggerFactory .getILoggerFactory .asInstanceOf [ch.qos.logback.classic.LoggerContext]
    def df_default_as = {
      val fu_jc = new ch.qos.logback.classic.joran.JoranConfigurator
      fu_jc .setContext (du_lc)
      du_lc .reset
      val fu_cfg_xml_str = s"""
        <configuration>
          <statusListener class="ch.qos.logback.core.status.NopStatusListener" />
          <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
            <layout class="ch.qos.logback.classic.PatternLayout">
              <Pattern>
                [${ "%04d" .format (GC_THIS_PID) },%.-1level,%date{yyMMdd-HHmmss}] %msg%n
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
          <logger name="slick" level="INFO" />
        </configuration>
      """
      fu_jc .doConfigure ( new java.io.ByteArrayInputStream ( fu_cfg_xml_str .getBytes ) )
      akka.actor.ActorSystem .create ( "GC_AS", com.typesafe.config.ConfigFactory .parseString ( """
        akka {
          loggers = ["akka.event.slf4j.Slf4jLogger"]
          loglevel = "DEBUG"
          logging-filter = "akka.event.slf4j.Slf4jLoggingFilter"
        }
      """ ) )
    }
  }
  lazy val GC_AS = __DgPrivate.df_default_as
  def gf_mk_atr ( x_arf : Object = GC_AS ) ( x_at_cls : Class [ _ <: akka.actor.Actor ], x_args : Seq [Any], x_at_nm : String ) = {
    val fu_arf = x_arf .asInstanceOf [akka.actor.ActorRefFactory]
    x_at_nm match {
      case ":c" => fu_arf .actorOf ( akka.actor.Props ( x_at_cls, x_args : _* ), x_at_cls.getName )
      case ":a" => fu_arf .actorOf ( akka.actor.Props ( x_at_cls, x_args : _*  ) )
      case bu2_it => fu_arf .actorOf ( akka.actor.Props ( x_at_cls, x_args : _* ), bu2_it )
    }
  }

  lazy val GC_LOG = GC_AS.log
  def gp_set_log_level_to_info = GC_AS .eventStream .setLogLevel (akka.event.Logging.InfoLevel)
  def gp_set_log_level_to_debug = GC_AS .eventStream .setLogLevel (akka.event.Logging.DebugLevel)
  def gp_log_seq [O] ( xp_out : String => Unit = GC_LOG .info ) ( xn_title : => Object ) ( xn_seq : => Seq [O] ) {
    xp_out ( s"${xn_title.toString} =>" )
    for ( ( bu2_it, bu2_idx ) <- xn_seq.view.zipWithIndex ) xp_out ( s"  ${ "%2d" format ( bu2_idx + 1 ) } : ${ bu2_it.toString }" )
  }
  def gp_log_header ( xp_out : String => Unit = GC_LOG .info ) ( x_header : String, x_line_width : Int = 60 ) {
    xp_out ( "+" + "-" * x_line_width )
    xp_out ( s": ${x_header}" )
    xp_out ( "+" + "-" * x_line_width )
  }
  def gp_log_exception ( xp_out : String => Unit = GC_LOG .error ) ( xn_title : => Object ) ( xn_ex : => Exception ) {
    gp_log_header (xp_out) ( xn_title .toString )
    xp_out (xn_ex.getMessage)
    for ( bu2_it <- xn_ex.getStackTrace ) xp_out ( s"  ${ bu2_it.toString }" )
  }

  case class LgCx ( lu_ec : Int, lu_ex : Exception )

  private object __DgExit {
    private var __dav_cx = LgCx ( GC_EC_NONE, null )
    private var __dav_was_lgcx_processed = false
    def dp_it ( x_cx : LgCx ) {
      GC_LOG .debug ( s"Received LgCx ${x_cx.lu_ec}" )
      if ( __dav_was_lgcx_processed == false ) {
        __dav_was_lgcx_processed = true
        __dav_cx = x_cx
        GC_LOG .debug ( "Terminating GC_AS ..." )
        __dap_before_exit
        __dap_exit
      }
    }
    private def __dap_before_exit {
      val pu_ec = __dav_cx.lu_ec
      if ( pu_ec != GC_EC_SUCCESS ) { gp_log_seq () {"CLASSPATH"} { ClassLoader .getSystemClassLoader .asInstanceOf [java.net.URLClassLoader] .getURLs .sortBy (_.getPath) .map  { it => gf_to_prs (it.getPath) } } }
      val pu_ex = __dav_cx.lu_ex
      if ( pu_ex != null ) gp_log_exception () { "Following error occurs !!!" } {pu_ex}
      if ( pu_ec != GC_EC_SUCCESS && pu_ex == null ) gp_log_header (GC_LOG.error) ( "Unknown error occurs !!!" )
      pu_ec match {
        case GC_EC_NONE => GC_LOG .error ( "Undefined exit code (GC_EC_NONE), check your logic !!!" )
        case GC_EC_SHUTDOWN => GC_LOG .info ( "Exit code from shutdown like ctrl+c, ..." )
        case bu2_ec if bu2_ec < 0 => GC_LOG .error ( s"Negative exit code (${bu2_ec}), should consider using a positive value !!!" )
        case bu2_ec => GC_LOG .info ( s"Exit code => ${pu_ec}" )
      }
      GC_LOG .info ( s"Elapsed ${ ( System.currentTimeMillis - GC_ST ) / 1000.0 } ..." )
      GC_AS .terminate
      scala.concurrent.Await .ready ( GC_AS.whenTerminated, scala.concurrent.duration.Duration.Inf )
      __DgPrivate.du_lc.stop
    }
    private def __dap_exit {
      val pu_ec = __dav_cx.lu_ec
      pu_ec match {
        case GC_EC_NONE => sys.exit (GC_EC_ERROR)
        case GC_EC_SHUTDOWN => ()
        case bu2_ec if bu2_ec < 0 =>  sys.exit (GC_EC_ERROR)
        case bu2_ec => sys.exit (bu2_ec)
      }
    }
  }

  def gp_request_exit ( x_ec : Int, x_ex : Exception ) { __DgExit .dp_it ( LgCx ( x_ec, x_ex ) ) }
  def gp_register_on_termination ( xnu_do : => Unit ) { GC_AS registerOnTermination { xnu_do } }
  sys.addShutdownHook { gp_request_exit ( GC_EC_SHUTDOWN, new Exception ( "Shutdown occurred !!!" ) ) }

  def gf_replace_with_px_symbol ( x_pn : String, x_px_path : String, x_px_symbol : String ) = {
    val fu_pn = gf_ap (x_pn)
    if ( fu_pn.startsWith (s"${x_px_path}/") ) gf_pj ( x_px_symbol, fu_pn.replaceFirst ( s"^${x_px_path}/", "" ) ) else fu_pn
  }
  def gf_to_prs ( x_pn : String ) = gf_replace_with_px_symbol ( x_pn, GC_PYJA_RT, GC_PYJA_RT_SYM ) // to (p)yja (r)oot (s)ymbol
  def gf_to_phs ( x_pn : String ) = gf_replace_with_px_symbol ( x_pn, GC_PYJA_HM, GC_PYJA_HM_SYM ) // to (p)yja (h)ome (s)ymbol
  def gf_to_mps ( x_pn : String ) = gf_replace_with_px_symbol ( x_pn, GC_MILO_PN, GC_MILO_PN_SYM ) // to (m)ilo (p)ath (s)ymbol

  private object __CgFxApp {
    private var __casp_start : ( javafx.application.Application, javafx.stage.Stage ) => Unit = _
    def csn_launch ( xnu_start : ( javafx.application.Application, javafx.stage.Stage ) => Unit ) {
      __casp_start = xnu_start; javafx.application.Application .launch ( classOf [__CgFxApp] )
    }
  }; class __CgFxApp extends javafx.application.Application { override def start ( x_stage : javafx.stage.Stage ) { __CgFxApp.__casp_start ( this, x_stage) } }
  def gp_fx_start ( xnu_start : ( javafx.application.Application, javafx.stage.Stage ) => Unit ) {
    new Thread { override def run { __CgFxApp .csn_launch (xnu_start) } } .start
  }

  def gp_xr ( xnu_do : => Unit ) { javafx.application.Platform .runLater { () => xnu_do } }
  def gp_qr ( xnu_do : => Unit ) { com.trolltech.qt.core.QCoreApplication .invokeLater { () => xnu_do } }
}

//
// Main Skeleton
//

import Global._

object DRun {
  private var __dav_ec = GC_EC_NONE
  private var __dav_ex : Exception = null
  println ( __daf_banner () .mkString ("\n") )
  private def __dap_begin {
    GC_LOG .info  ( s"Pyja name => ${GC_PYJA_NM}" )
    if ( GC_PYJA_NM != gf_os_env ('SC_PYJA_NM) ) throw new Exception ( "Invalid Pyja name !!!" )
    GC_LOG .info  ( s"Pyja creation date => ${GC_PYJA_CD}" )
    if ( ! gf_str_is_valid_date ( GC_PYJA_CD, "yyyy.mm.dd" ) ) throw new Exception ( "Pyja create date is not invalid !!!" )
    GC_LOG .info  ( s"Pyja version => ${GC_PYJA_V2}" )
    if ( GC_PYJA_VR != gf_os_env ('SC_PYJA_VR) ) throw new Exception ( "Invalid Pyja version !!!" )
    GC_LOG .info  ( s"Pyja root (${GC_PYJA_RT_SYM}) => ${GC_PYJA_RT}" )
    GC_LOG .info  ( s"Pyja home (${GC_PYJA_HM_SYM}) => ${ gf_to_prs (GC_PYJA_HM) }" )
    GC_LOG .info  ( s"Milo path (${GC_MILO_PN_SYM}) => ${ gf_to_phs (GC_MILO_PN) }" )
    GC_LOG .info  ( s"Java home => ${GC_JAVA_HM}" )
    GC_LOG .debug ( s"Scala version => ${util.Properties.versionMsg}" )
    GC_LOG .debug ( s"Total CPU => ${GC_TOTAL_CPU}" )
    GC_LOG .debug ( s"Total memory => ${ "%,d" .format (GC_TOTAL_MEMORY) } bytes" )
    GC_LOG .debug ( s"Computer name => ${GC_HOST_NM}" )
    GC_LOG .debug ( s"Current user => ${GC_CUSR}" )
    GC_LOG .debug ( s"Process ID => ${GC_THIS_PID}" )
    GC_LOG .info  ( s"Start up path => ${ gf_to_phs (GC_THIS_START_UP_PN) }" )
    GC_LOG .info  ( s"Application JAR file => ${ gf_to_mps (GC_THIS_JAR_FN) }" )
    gp_log_seq (GC_LOG.debug) {"Paths"} {GC_OS_ENV_PATHS}
    if ( GC_ARGV.length > 0 ) gp_log_seq () {"Arguments"} {GC_ARGV}
  }
  def dp_it {
    try {
      __dap_begin
      DBody .dp_it
      __dav_ec = com.trolltech.qt.gui.QApplication .execStatic ()
    } catch {
      case bu2_ex : Exception =>
        __dav_ec = GC_EC_ERROR
        __dav_ex = bu2_ex
    } finally {
      GC_LOG .info  ( "QApplication exited" )
      gp_request_exit ( __dav_ec, __dav_ex )
    }
  }
  private def __daf_banner ( x_leading_space : Int = 0, x_margin_inside : Int = 2 ) = {
    val fu_msgs = List (
      s"${GC_PYJA_NM} ${GC_APP_NM}",
      "",
      s"ran on ${ java.time.LocalDateTime .now () .format ( java.time.format.DateTimeFormatter .ofPattern ("yyyy-MM-dd HH:mm:ss") ) }",
      "released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.",
    )
    val fu_msl = fu_msgs .map (_.length) .max // max string length
    val fu_ls = x_leading_space // leading space before box
    val fu_mg = x_margin_inside // margin inside box
    val fu_ll = fu_mg + fu_msl + fu_mg // line length inside box
    val fu_ln = " " * fu_ls + "+" + "-" * fu_ll + "+"
    def ff2_ln_from_str ( x2_str : String ) = {
      val fu2_sl = x2_str.length // string lentgh
      val fu2_lm = ( ( fu_ll - fu2_sl ) / 2.0 ) .toInt // left margin inside box
      val fu2_rm = fu_ll - ( fu2_sl + fu2_lm ) // right margin inside box
      " " * fu_ls + ":" + " " * fu2_lm + x2_str + " " * fu2_rm + ":" 
    }
    List (fu_ln) ::: fu_msgs .map (ff2_ln_from_str) ::: List (fu_ln)
  }
}

//
// Your Source
//

import com.trolltech.qt.core.QCoreApplication
import com.trolltech.qt.gui.QApplication

class WAtFxMain ( wu_stg : javafx.stage.Stage ) extends akka.actor.Actor {
  import scala.concurrent.duration._
  import slick.jdbc.H2Profile.api._
  lazy val wu_root = new javafx.scene.layout.StackPane
  lazy val wu_scene = new javafx.scene.Scene (wu_root)
  lazy val wu_lv = new javafx.scene.control.ListView [String]
  gp_xr { wn_init }
  override def receive : Receive = { case _ => () }
  def wn_init {
    gf_tap (wu_root) { it => it .getChildren .addAll (wu_lv) }
    gf_tap (wu_stg) { it =>
      it .setTitle (GC_APP_NM)
      it .setWidth (555)
      it .setHeight (257)
      it .setScene (wu_scene)
      it .setOnShown { _ =>
        GC_LOG .info ( s"${this.getClass.getName} => OnShown" )
        wn_shown
      }
      it .setOnCloseRequest { _ =>
        GC_LOG .info ( s"${this.getClass.getName} => OnCloseRequest" )
        QCoreApplication .exit (GC_EC_SUCCESS)
      }
      it .show
    }
  }
  def wn_display ( x_msg : String ) {
    GC_LOG .info (x_msg)
    wu_lv .getItems .add (x_msg)
  }
  def wn_shown {
    final case class RMessage (
      ru_sender  : String,
      ru_content : String,
      ru_id      : Long = 0L,
    )
    val nu_fresh_test_data = Seq (
      RMessage ( "Dave", "Hello, HAL. Do you read me, HAL?" ),
      RMessage ( "HAL",  "Affirmative, Dave. I read you." ),
      RMessage ( "Dave", "Open the pod bay doors, HAL." ),
      RMessage ( "HAL",  "I'm sorry, Dave. I'm afraid I can't do that." ),
    )
    final class TMessage ( tu_tag : Tag ) extends Table [RMessage] ( tu_tag, "t_message" ) {
      def co_id      = column [Long]   ( "ru_id", O.PrimaryKey, O.AutoInc )
      def co_sender  = column [String] ( "ru_sender" )
      def co_content = column [String] ( "ru_content" )
      def * = ( co_sender, co_content, co_id ) .mapTo [RMessage]
    }
    val nu_db = Database.forURL ( s"jdbc:h2:mem:${GC_APP_NM};DB_CLOSE_DELAY=-1", driver = "org.h2.Driver" )
    lazy val nu_messages = TableQuery [TMessage]
    val nu_hal_says = nu_messages .filter ( _.co_sender === "HAL" )
    def nf2_exec [T] ( x_program : DBIO [T] ) : T = scala.concurrent.Await .result ( nu_db.run (x_program), 2.seconds )
    GC_LOG .info ( "Creating database table ..." )
    nf2_exec (nu_messages.schema.create)
    GC_LOG .info ( "Inserting test data ..." )
    nf2_exec ( nu_messages ++= nu_fresh_test_data )
    gp_log_seq (wn_display) { "Selecting all messages" } { nf2_exec (nu_messages.result) .map ( it => it ) }
    gp_log_seq (wn_display) { "Selecting only messages from HAL" } { nf2_exec (nu_hal_says.result) .map ( it => it ) }
  }
}

object DBody {
  List (
    // jar*
    gf_pj ( GC_PYJA_HM, "Library", "H2", "1.4.196", "h2-1.4.196.jar" ),
    // *raj
  ) .foreach { bx2_jar_fn => gp_add_jar (bx2_jar_fn) }
  def dp_it {
    gp_register_on_termination {
      // Code to run after termination of GC_AS, in this block you can't use GC_LOG
    }
    QApplication .setStyle ( new com.trolltech.qt.gui.QPlastiqueStyle )
    gp_fx_start { ( bx2_app, bx2_stage ) => gf_mk_atr () ( classOf [WAtFxMain], Seq (bx2_stage), ":c" ) }
  }
}

object OStart {
  def main ( x_args : Array [String] ) {
    gp_set_argv (x_args)
    gp_set_log_level_to_info
    DRun .dp_it
  }
}
