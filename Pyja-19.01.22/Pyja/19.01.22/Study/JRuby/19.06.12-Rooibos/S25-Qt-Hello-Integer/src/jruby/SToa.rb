#---------------------------------------------------------------
# Your Source
#---------------------------------------------------------------

-> () {
  pu_tono_hm = Java::ORun.ol_gr .get 'GC_TONO_HM'
  $LOAD_PATH .unshift pu_tono_hm unless $LOAD_PATH .include? pu_tono_hm
} .()

require 'src/jruby/Global'

import com.trolltech.qt.gui.QApplication
import com.trolltech.qt.gui.QDesktopWidget
import com.trolltech.qt.gui.QMainWindow
import com.trolltech.qt.gui.QPushButton
import com.trolltech.qt.gui.QSizePolicy
import com.trolltech.qt.gui.QVBoxLayout
import com.trolltech.qt.gui.QWidget

class CAtInteger
  def create x_value; @cv_value = x_value; end
  def receive x_letter
    case x_letter
    when :LCurrent then
      getSender .tell @cv_value, getSelf
    when :LNext then
      cn_change_value
      getSender .tell @cv_value, getSelf
    end
  end
  def cn_change_value
    @cv_value = ( @cv_value >= CgInteger::MAX_VALUE ) ? 1 : @cv_value + 1
  end
end

class WAtQtMain < QMainWindow
  def initialize; super; end
  def create x_atr_integer
    @wu_atr_integer = x_atr_integer
    gp_qr { cn_create }
  end
  def receive x_letter
    gp_qr { wn_set_pb_text x_letter }
  end
  def cn_create
    set_window_title "[Qt] #{GC_TONO_NM} (#{ gf_bn gf_os_env('SC_VBS_FN') })"
    nu_cw = QWidget .new
    nu_lo = QVBoxLayout .new
    @wu_pb = QPushButton .new .tap { |it|
      it .set_size_policy QSizePolicy::Policy::Expanding, QSizePolicy::Policy::Fixed
      gp_gco it.pressed, -> () {
        @wu_atr_integer .tell :LNext, getSelf
      }
    }
    nu_lo .add_widget @wu_pb
    nu_cw.layout = nu_lo
    set_central_widget nu_cw
    resize 410, 150
    # wn_move_position
    show
    raise
  end
  def showEvent x_ev
    GC_LOG .info gf_wai
    @wu_atr_integer .tell :LCurrent, getSelf
    getContext.system.scheduler .schedule CgDuration::Zero(), CgDuration.create( 1500, CgTimeUnit::MILLISECONDS ), @wu_atr_integer, :LNext, getContext.system.dispatcher, getSelf
  end
  def closeEvent x_ev
    GC_LOG .info gf_wai 'About to quit ...'
    gp_request_exit GC_EC_SUCCESS
  end
  def wn_set_pb_text x_cnt
    GC_LOG .info "[Qt] #{ @wu_pb .text }" unless @wu_pb.text .to_s .empty?
    @wu_pb .set_text gf_sf "Hello, %,d !", x_cnt
  end
  def wn_move_position
    nu_cp = QDesktopWidget .new .available_geometry.center # center point
    move nu_cp.x - width, nu_cp.y - height/2
  end
end

module DBody
  def self .dp_it
    gp_register_on_termination { # Code to run after termination of GC_AS, in this block you can't use GC_LOG
    }
    QApplication .initialize [] .to_java :string
    pu_atr_integer = gf_mk_atr_ro CAtInteger .new, [ CgInteger::MAX_VALUE - 100_000 ], :c
    gf_mk_atr_ro WAtQtMain .new, [pu_atr_integer], :c
    QApplication .exec_static
  end
end

def sp_main
  DRun .dp_it
end

sp_main
