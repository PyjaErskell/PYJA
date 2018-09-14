//
// Global
//

object Global {
  import scala.collection.JavaConverters._

  def gp_initialize = {}
  def gf_wai ( x_msg : String = null ) : String = {
    val fu_st = Thread .currentThread () .getStackTrace () (2)
    val fu_wai = s"@ ${ fu_st .getClassName () }.${ fu_st .getMethodName () } [${ "%03d" .format ( fu_st .getLineNumber () ) }]"
    if ( x_msg == null ) return fu_wai
    else return s"${fu_wai} ${x_msg}"
  }

  val GC_JEP = ORun.ol_jep
  val GC_FX_STAGE = ORun.ol_fx_stage
  val GC_LOG = GC_JEP .getValue ("JC_LOG") .asInstanceOf [org.slf4j.Logger]

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

  GC_LOG .trace ( gf_wai ( "Initializing Scala Global ..." ) )

  val GC_PYJA_NM = GC_JEP .getValue ("GC_PYJA_NM") .asInstanceOf [String]
  val GC_PYJA_AU = GC_JEP .getValue ("GC_PYJA_AU") .asInstanceOf [String]

  val GC_PJYA_CEN = GC_JEP .getValue ("GC_PJYA_CEN") .asInstanceOf [Long]
  val GC_PYJA_YEA = GC_JEP .getValue ("GC_PYJA_YEA") .asInstanceOf [Long]
  val GC_PYJA_MON = GC_JEP .getValue ("GC_PYJA_MON") .asInstanceOf [Long]
  val GC_PYJA_DAY = GC_JEP .getValue ("GC_PYJA_DAY") .asInstanceOf [Long]

  val GC_PYJA_CD = GC_JEP .getValue ("GC_PYJA_CD") .asInstanceOf [String]
  val GC_PYJA_VR = GC_JEP .getValue ("GC_PYJA_VR") .asInstanceOf [String]
  val GC_PYJA_V2 = GC_JEP .getValue ("GC_PYJA_V2") .asInstanceOf [String]

  val GC_PYJA_VER_MAJ = GC_PYJA_YEA // Major 
  val GC_PYJA_VER_MIN = GC_PYJA_MON // Minor
  val GC_PYJA_VER_PAT = GC_PYJA_DAY // Patch

  val GC_PYJA_RT = GC_JEP .getValue ("GC_PYJA_RT") .asInstanceOf [String]
  val GC_PYJA_HM = GC_JEP .getValue ("GC_PYJA_HM") .asInstanceOf [String]
  val GC_MILO_PN = GC_JEP .getValue ("GC_MILO_PN") .asInstanceOf [String]

  val GC_PYJA_RT_SYM = GC_JEP .getValue ("GC_PYJA_RT_SYM") .asInstanceOf [String]
  val GC_PYJA_HM_SYM = GC_JEP .getValue ("GC_PYJA_HM_SYM") .asInstanceOf [String]
  val GC_MILO_PN_SYM = GC_JEP .getValue ("GC_MILO_PN_SYM") .asInstanceOf [String]

  val GC_KAPA_HM = GC_JEP .getValue ("GC_KAPA_HM") .asInstanceOf [String]
  val GC_JAVA_HM = GC_JEP .getValue ("GC_JAVA_HM") .asInstanceOf [String]
  val GC_PYTHON_HM = GC_JEP .getValue ("GC_PYTHON_HM") .asInstanceOf [String]

  val GC_EC_NONE     = GC_JEP .getValue ("GC_EC_NONE") .asInstanceOf [Long]
  val GC_EC_SHUTDOWN = GC_JEP .getValue ("GC_EC_SHUTDOWN") .asInstanceOf [Long]
  val GC_EC_SUCCESS  = GC_JEP .getValue ("GC_EC_SUCCESS") .asInstanceOf [Long]
  val GC_EC_ERROR    = GC_JEP .getValue ("GC_EC_ERROR") .asInstanceOf [Long]
  
  val GC_FOSA = GC_JEP .getValue ("GC_FOSA") .asInstanceOf [String]
  val GC_PASA = GC_JEP .getValue ("GC_PASA") .asInstanceOf [String]

  val GC_PYTHON_VR = GC_JEP .getValue ("GC_PYTHON_VR") .asInstanceOf [String]
  val GC_PYQT_VR = GC_JEP .getValue ("GC_PYQT_VR") .asInstanceOf [String]
  
  val GC_TOTAL_CPU    = GC_JEP .getValue ("GC_TOTAL_CPU") .asInstanceOf [Long]
  val GC_TOTAL_MEMORY    = GC_JEP .getValue ("GC_TOTAL_MEMORY") .asInstanceOf [Long]

  val GC_HOST_NM = GC_JEP .getValue ("GC_HOST_NM") .asInstanceOf [String]
  val GC_CUSR = GC_JEP .getValue ("GC_CUSR") .asInstanceOf [String]
  val GC_OS_ENV_PATHS = GC_JEP .getValue ("GC_OS_ENV_PATHS") .asInstanceOf [java.util.ArrayList[String]] .asScala

  val GC_THIS_PID    = GC_JEP .getValue ("GC_THIS_PID") .asInstanceOf [Long]
  val GC_THIS_EXE_FN = GC_JEP .getValue ("GC_THIS_EXE_FN") .asInstanceOf [String]
  val GC_THIS_START_UP_PN = GC_JEP .getValue ("GC_THIS_START_UP_PN") .asInstanceOf [String]

  val GC_DESKTOP_PN = GC_JEP .getValue ("GC_DESKTOP_PN") .asInstanceOf [String]
  val GC_DOWNLOAD_PN = GC_JEP .getValue ("GC_DOWNLOAD_PN") .asInstanceOf [String]

  val GC_THIS_CMD = GC_JEP .getValue ("GC_THIS_CMD") .asInstanceOf [java.util.ArrayList[String]] .asScala

  val GC_APP_NM = GC_JEP .getValue ("GC_APP_NM") .asInstanceOf [String]
  val GC_ARGV = GC_JEP .getValue ("GC_ARGV") .asInstanceOf [java.util.ArrayList[String]] .asScala

  val GC_TCL_VR = GC_JEP .getValue ("GC_TCL_VR") .asInstanceOf [String]

  val GC_OS_NM = GC_JEP .getValue ("JC_OS_NM") .asInstanceOf [String]
  val GC_IS_LINUX = GC_JEP .getValue ("JC_IS_LINUX") .asInstanceOf [Boolean]
  val GC_IS_MAC = GC_JEP .getValue ("JC_IS_MAC") .asInstanceOf [Boolean]
  val GC_IS_WIN = GC_JEP .getValue ("JC_IS_WIN") .asInstanceOf [Boolean]

  val GC_AKKA_VR = GC_JEP .getValue ("JC_AKKA_VR") .asInstanceOf [String]
  val GC_GROOVY_VR = GC_JEP .getValue ("JC_GROOVY_VR") .asInstanceOf [String]
  val GC_JAVA_VR = GC_JEP .getValue ("JC_JAVA_VR") .asInstanceOf [String]
  val GC_SCALA_VR = GC_JEP .getValue ("JC_SCALA_VR") .asInstanceOf [String]

  val GC_GR = GC_JEP .getValue ("JC_GR") .asInstanceOf [javax.script.ScriptEngine]
  val GC_AS = GC_JEP .getValue ("JC_AS") .asInstanceOf [akka.actor.ActorSystem]
  
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
    if ( x_str .startsWith (x_px) ) x_str .replaceFirst ( s"^${x_px}", "" ) else x_str
  }
  def gf_b2fs ( x_it : String ) = { x_it .replaceAll ( "\\\\", "/" ) } // replace backslash to forwardslash
  def gf_ap ( x_it : String, x_canonical : Boolean = true ) = { // absolute path
    val fu_fl = new java.io.File (x_it)
    gf_b2fs ( if (x_canonical) fu_fl .getCanonicalPath () else fu_fl .getAbsolutePath () )
  }
  def gf_bn ( x_fn : String ) = java.nio.file.Paths .get (x_fn) .getFileName () .toString () // base name
  def gf_jn ( x_fn : String ) = { // just name without extension
    val fu_bn = gf_bn (x_fn)
    fu_bn .substring ( 0, fu_bn .lastIndexOf (".") )
  }
  def gf_if ( x_fn : String ) = new java.io.File (x_fn) .isFile ()
  def gf_id ( x_pn : String ) = new java.io.File (x_pn) .isDirectory ()
  def gf_pj ( x_args : String* ) = { gf_b2fs ( x_args .mkString ("/") ) } // path join

  def gf_replace_with_px_symbol ( x_pn : String, x_px_path : String, x_px_symbol : String ) = {
    val fu_pn = gf_ap (x_pn)
    if ( fu_pn .startsWith (s"${x_px_path}/") ) gf_pj ( x_px_symbol, fu_pn .replaceFirst ( s"^${x_px_path}/", "" ) ) else fu_pn
  }
  def gf_to_prs ( x_pn : String ) = gf_replace_with_px_symbol ( x_pn, GC_PYJA_RT, GC_PYJA_RT_SYM ) // to (p)yja (r)oot (s)ymbol
  def gf_to_phs ( x_pn : String ) = gf_replace_with_px_symbol ( x_pn, GC_PYJA_HM, GC_PYJA_HM_SYM ) // to (p)yja (h)ome (s)ymbol
  def gf_to_mps ( x_pn : String ) = gf_replace_with_px_symbol ( x_pn, GC_MILO_PN, GC_MILO_PN_SYM ) // to (m)ilo (p)ath (s)ymbol

  def gf_jal_2_seq ( x_jal : java.util.ArrayList [Object] ) = x_jal .asScala
  def gf_mk_atr ( x_arf : Object = GC_AS ) ( x_at_cls : Class [ _ <: akka.actor.Actor ], x_args : Seq [Any], x_at_nm : String ) = {
    val fu_arf = x_arf .asInstanceOf [akka.actor.ActorRefFactory]
    x_at_nm match {
      case ":c" => fu_arf .actorOf ( akka.actor.Props ( x_at_cls, x_args : _* ), x_at_cls.getName )
      case ":a" => fu_arf .actorOf ( akka.actor.Props ( x_at_cls, x_args : _*  ) )
      case bu2_it => fu_arf .actorOf ( akka.actor.Props ( x_at_cls, x_args : _* ), bu2_it )
    }
  }
}

//
// Your Source
//

import Global._
import scala.collection.JavaConverters._

import akka.actor.Actor
import akka.actor.ActorRef
import ch.qos.logback.classic.{Level=>CLogLevel}
import scala.concurrent.duration._
import slick.jdbc.H2Profile.api._

case class LAddMessage ( lu_it : RMessage )
case class LDisplay ( lu_level : CLogLevel, lu_msg : String )
case class LSelectSender ( lu_it : String )

final case class RMessage (
  ru_sender  : String,
  ru_content : String,
  ru_id      : Long = 0L,
)
final class TMessage ( tu_tag : Tag ) extends Table [RMessage] ( tu_tag, "t_message" ) {
  def co_id      = column [Long]   ( "ru_id", O.PrimaryKey, O.AutoInc )
  def co_sender  = column [String] ( "ru_sender" )
  def co_content = column [String] ( "ru_content" )
  def * = ( co_sender, co_content, co_id ) .mapTo [RMessage]
}

class CAtSlick ( cu_atr_main : ActorRef ) extends Actor {
  val cu_db = Database.forURL ( s"jdbc:h2:mem:${GC_APP_NM};DB_CLOSE_DELAY=-1", driver = "org.h2.Driver" )
  val cu_messages = TableQuery [TMessage]
  def receive = {
    case 'LCreateTable => {
      cn_display_info ( gf_wai ( "Creating database table ..." ) )
      cm_exec (cu_messages.schema.create)
    }
    case LAddMessage (bu2_it) => {
      cn_display_info ( gf_wai ( s"  adding message ${bu2_it} ..." ) )
      cm_exec ( cu_messages += bu2_it )
    }
    case 'LSelectAll => gp_log_seq (cn_display_info) { "Selecting all messages" } { cm_exec (cu_messages.result) .map ( it => it ) }
    case LSelectSender (bu2_it) => gp_log_seq (cn_display_info) { s"Selecting only messages from ${bu2_it}" } {
      cm_exec ( cu_messages .filter ( _.co_sender === bu2_it ) .result ) .map ( it => it )
    }
    case bu2_invalid => cn_display ( CLogLevel.ERROR, gf_wai ( s"Message ${bu2_invalid} not recognized" ) )
  }
  def cm_exec [T] ( x_program : DBIO [T] ) : T = scala.concurrent.Await .result ( cu_db.run (x_program), 2.seconds )
  def cn_display ( x_level : CLogLevel, x_msg : String ) = cu_atr_main ! LDisplay ( x_level, x_msg )
  def cn_display_info ( x_msg : String ) = cn_display ( CLogLevel.INFO, x_msg )
}
