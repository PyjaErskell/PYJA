#---------------------------------------------------------------
# Global
#---------------------------------------------------------------

require 'fileutils'
require 'hash_dot'
require 'heredoc_unindent'

Hash.use_dot_syntax = true

CgInteger = Java::JavaLang::Integer
CgString = Java::JavaLang::String
CgSystem = Java::JavaLang::System

CgActorRef = Java::AkkaActor::ActorRef
CgAwait = Java::ScalaConcurrent::Await
CgDuration = Java::ScalaConcurrentDuration::Duration
CgFile = java.io.File
CgTimeUnit = java.util.concurrent.TimeUnit

GC_PS = Java::ORun.ol_ps
GC_GR = Java::ORun.ol_gr

def gf_gg x_it; GC_GR .get x_it .to_s; end
def gy_ge x_str; GC_GR .eval x_str; end
def gy_gf x_fn_nm, * x_args; GC_GR .invoke_function x_fn_nm .to_s, * x_args; end

GC_EC_NONE = gf_gg :GC_EC_NONE
GC_EC_SHUTDOWN = gf_gg :GC_EC_SHUTDOWN
GC_EC_SUCCESS = gf_gg :GC_EC_SUCCESS
GC_EC_ERROR = gf_gg :GC_EC_ERROR

GC_TONO_NM = gf_gg :GC_TONO_NM
GC_TONO_ARGV = gf_gg :GC_TONO_ARGV

GC_AS = gf_gg :GC_AS
GC_LOG = gf_gg :GC_LOG

def gp_log_array xp_out = ( GC_LOG .method :info ), x_title, x_array
  return if x_array .empty?
  xp_out .call "#{x_title} =>"
  x_array .each .with_index (1) { | bx2_it, bx2_idx | xp_out .call "  #{'%2d' % bx2_idx} : #{bx2_it}" }
end
def gp_log_header xp_out = ( GC_LOG .method :info ), x_header, x_line_width
  xp_out .call '+' + '-' * x_line_width
  xp_out .call ": #{x_header}"
  xp_out .call '+' + '-' * x_line_width
end

def gf_sf x_format, * x_args; gy_gf :gf_sf, x_format, * x_args; end

def gf_to_ths x_pn; gy_gf :gf_to_ths, x_pn; end

def gp_request_exit x_ec, x_ex_list = []; gy_gf :gp_request_exit, x_ec, x_ex_list; end

def gf_exception_to_list x_ex
  fu_list = [ x_ex.message ]
  x_ex .backtrace .each { |bx2_it| fu_list << bx2_it } unless x_ex .backtrace .nil?
  fu_list
end

def gf_wai x_msg = nil
  fu_cl = ( caller_locations 1, 1 ) [0]
  fu_msg = "#{fu_cl.label} [#{ gf_to_ths fu_cl.path }:#{ '%04d' % fu_cl.lineno }]"
  return fu_msg if x_msg .nil?
  "#{fu_msg} #{x_msg}"
end

def gf_jr & x_blk # (j)ava (r)unnable
  Class .new {
    include Java::JavaLang::Runnable
    def initialize x_blk; @__cau_block = x_blk; end
    def run; @__cau_block .call; end
  } .new x_blk
end

def gp_register_on_termination; GC_AS .register_on_termination gf_jr { yield if block_given? }; end

def gp_br & x_blk # (b)egin (r)escue
  x_blk .call
rescue Exception => bu2_ex
  gp_request_exit GC_EC_ERROR, ( gf_exception_to_list bu2_ex )
end

def gp_qr & x_blk; com.trolltech.qt.core.QCoreApplication .invokeLater { gp_br { x_blk .call } }; end

def gp_gco x_signal, & x_blk # gco = si(g)nal (c)onnect sl(o)t
  pu_slot = gy_gf "gf_qs#{x_blk.arity}", x_blk
  x_signal .connect *pu_slot
end

#---------------------------------------------------------------
# Main Skeleton
#---------------------------------------------------------------

module DRun
  def self .dp_it
    gp_br {
      __dap_begin
      DBody .dp_it
    }
  end
private
  def self .__dap_begin
    GC_LOG .info  "JRuby version => #{JRUBY_VERSION}"
    GC_LOG .info  "Ruby version => #{RUBY_VERSION}"
    gp_log_array  'Arguments', GC_TONO_ARGV if GC_TONO_ARGV.count > 0
  end
end

#---------------------------------------------------------------
# Your Source
#---------------------------------------------------------------

import com.trolltech.qt.gui.QApplication
import com.trolltech.qt.gui.QDesktopWidget
import com.trolltech.qt.gui.QMainWindow
import com.trolltech.qt.gui.QPushButton
import com.trolltech.qt.gui.QSizePolicy
import com.trolltech.qt.gui.QVBoxLayout
import com.trolltech.qt.gui.QWidget

class WMain < QMainWindow
  def initialize
    super
    @wv_cnt = ( CgInteger::MAX_VALUE / 2 ) .to_i
    set_window_title GC_TONO_NM
    resize 350, 150
    nu_cw = QWidget .new
    nu_lo = QVBoxLayout .new
    @wu_pb = QPushButton .new .tap { |it|
      it .set_size_policy QSizePolicy::Policy::Expanding, QSizePolicy::Policy::Fixed
      gp_gco it.pressed do
        GC_LOG .info @wu_pb .text
        wn_set_pb_text wm_next
      end
    }
    wn_set_pb_text wm_current
    nu_lo .add_widget @wu_pb
    nu_cw.layout = nu_lo
    set_central_widget nu_cw
    show
    wn_move_center
    raise
    start_timer 10
    QApplication .exec_static
  end
  def timerEvent x_ev
    @wu_pb .click
  end
  def showEvent x_ev
    GC_LOG .info gf_wai
  end
  def closeEvent x_ev
    GC_LOG .info gf_wai 'About to quit ...'
    gp_request_exit GC_EC_SUCCESS
  end
  def wm_current; @wv_cnt; end
  def wm_next
    @wv_cnt = ( @wv_cnt >= CgInteger::MAX_VALUE ) ? 1 : @wv_cnt + 1
  end
  def wn_set_pb_text x_cnt; @wu_pb .set_text gf_sf "Ciao, %,d !", x_cnt; end
  def wn_move_center
    nu_cp = QDesktopWidget .new .available_geometry.center # center point
    move nu_cp.x - width / 2, nu_cp.y - height / 2
  end
end

module DBody
  def self .dp_it
    gp_register_on_termination { # Code to run after termination of GC_AS, in this block you can't use GC_LOG
    }
    QApplication .initialize [] .to_java :string
    WMain .new
  end
end

def sp_main
  DRun .dp_it
end

sp_main
