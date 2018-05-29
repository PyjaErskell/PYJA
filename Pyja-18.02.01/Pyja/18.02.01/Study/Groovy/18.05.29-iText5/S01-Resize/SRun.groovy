import groovy.transform.*
import com.trolltech.qt.core.*
import com.trolltech.qt.gui.*
import com.trolltech.qt.*
import com.itextpdf.*
import javax.swing.*
import java.text.DecimalFormat

class OStart {
  static void main(final x_args) {
    new CApp().cun_main(x_args)
  }
}

class DDocument {
  class DBinding {
    final static def DUSC_LEFT = 0
    final static def DUSC_TOP = 1
  }
}
class WMain extends QMainWindow {
  final static def WUSC_MINIMUM_LENGTH_MM = 10.0f
  final private QSignalEmitter.Signal1<Object> wagn_input_fl_choosed = new QSignalEmitter.Signal1<Object>(this)
  final static def WUSC_TITLE = new File ( System.getenv().SC_MILO_PN ) .getName ()
  final private def wau_main_gl = new QGridLayout()
  private def wam_create_io_pf_le() {
    new QLineEdit().with {
      setMinimumWidth(600)
      setAlignment(Qt.AlignmentFlag.AlignLeft)
      readOnly = true
      it
    }
  }
  private def wam_create_horizontal_line() {
    new QFrame(this).with {
      setGeometry new QRect(1, 1, 1, 1)
      setFrameShape QFrame.Shape.HLine
      setFrameShadow QFrame.Shadow.Sunken
      it
    }
  }
  private def wam_create_size_box() {
    new QDoubleSpinBox().with {
      setMinimum 0.0
      setMaximum 10000.0
      setDecimals 1
      setSingleStep 1.0f
      setSuffix " mm"
      setAlignment(Qt.AlignmentFlag.AlignRight)
      it
    }
  }
  final private def wau_horizontal_spacer = new QSpacerItem(1, 1, QSizePolicy.Policy.Expanding, QSizePolicy.Policy.Minimum)
  final private def wau_horizontal_spacer15 = new QSpacerItem(15, 1, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Minimum)

  final private def wau_io_pn_l = new QLabel("경로")
  final private def wau_io_pn_le = { 
    wam_create_io_pf_le().with {
      setText(new QDir("${System.getProperty("user.home")}${File.separator}Desktop").path())
      it
    }
  }()
  final private def wau_input_bn_l = new QLabel("입력파일")
  final private def wau_input_bn_le = wam_create_io_pf_le()
  final private def wau_input_fl_info_l = new QLabel("입력파일정보")
  final private def wau_input_fl_info_le = wam_create_io_pf_le()
  final private def wau_output_bn_l = new QLabel("저장파일")
  final private def wau_output_bn_le = wam_create_io_pf_le()
  final private def wau_settings_l = new QLabel("설정")
  final private def wau_settings_hbl = { 
    new QHBoxLayout().with {
      setSpacing 1
      it
    }
  }()
  final private def wau_to_size_width_mm_dsb = {
    wam_create_size_box().with {
      setPrefix "너비 "
      it
    }
  }()
  final private def wau_to_size_x_l = { 
    new QLabel("ⅹ").with {
      setMaximumWidth(20)
      it
    }
  }()
  final private def wau_to_size_height_mm_dsb = {
    wam_create_size_box().with {
      setPrefix "높이 "
      it
    }
  }()
  final private def wau_input_fn_pb = {
    new QPushButton("…").with {
      setMaximumWidth(25)
      it
    }
  }()
  final private def wau_is_duplex_chb = { 
    new QCheckBox("양면").with {
      setCheckState Qt.CheckState.Checked 
      it
    }
  }()
  final private def wau_binding_l = new QLabel("바인딩: ")
  final private def wau_binding_cbb = { 
    final def fau_it = new QComboBox()
    [["좌철", DDocument.DBinding.DUSC_LEFT],
     ["상철", DDocument.DBinding.DUSC_TOP],
    ].each {
      fau_it.addItem it
    }
    fau_it.setEditable false
    fau_it
  }()
  final private def wau_horizontal_alignment_l = new QLabel("수평배치: ")
  final private def wau_horizontal_alignment_cbb = { 
    final def fau_it = new QComboBox()
    [["좌측", Qt.AlignmentFlag.AlignLeft],
     ["중앙", Qt.AlignmentFlag.AlignCenter],
     ["우측", Qt.AlignmentFlag.AlignRight],
    ].each {
      fau_it.addItem it
    }
    fau_it.setEditable false
    fau_it
  }()
  final private def wau_vertical_alignment_l = new QLabel("수직배치: ")
  final private def wau_vertical_alignment_cbb = { 
    final def fau_it = new QComboBox()
    [["상측", Qt.AlignmentFlag.AlignTop],
     ["중앙", Qt.AlignmentFlag.AlignCenter],
     ["하측", Qt.AlignmentFlag.AlignBottom],
    ].each {
      fau_it.addItem it
    }
    fau_it.setEditable false
    fau_it
  }()
  final private def wau_processing_l = new QLabel("처리")
  final private def wau_resize_pb = {
    new QPushButton("크기 변환").with {
      setMaximumWidth(80)
      setEnabled false
      it
    }
  }()
  final private def wau_processing_pgb = {
    new QProgressBar().with {
      setMinimum 0
      setAlignment(Qt.AlignmentFlag.AlignCenter)
      it
    }
  }()
  final private def wau_log_te = {
    new QTextEdit().with {
      setReadOnly true
      setWordWrapMode QTextOption.WrapMode.NoWrap
      setMinimumHeight 250
      it
    }
  }()
  WMain(final x_parent=null) {
    setParent(x_parent)
    final def mau_align_right = new Qt.Alignment(Qt.AlignmentFlag.AlignRight)
    final def mau_align_center = new Qt.Alignment(Qt.AlignmentFlag.AlignCenter)

    [[wau_to_size_width_mm_dsb],
     [wau_to_size_x_l],
     [wau_to_size_height_mm_dsb],
     [wau_is_duplex_chb],
     [wau_binding_l],
     [wau_binding_cbb],
     [wau_horizontal_alignment_l],
     [wau_horizontal_alignment_cbb],
     [wau_vertical_alignment_l],
     [wau_vertical_alignment_cbb],
    ].each { 
      if(it[0] in [wau_is_duplex_chb, wau_binding_l, wau_horizontal_alignment_l, wau_vertical_alignment_l]) {
        wau_settings_hbl.addItem wau_horizontal_spacer15
      }
      wau_settings_hbl.addWidget it 
    }
    wau_settings_hbl.addItem wau_horizontal_spacer
    [[wau_input_fl_info_le.textChanged],
     [wau_to_size_width_mm_dsb.valueChanged],
     [wau_to_size_height_mm_dsb.valueChanged],
     [wau_is_duplex_chb.stateChanged ],
     [wau_binding_cbb.currentIndexChanged],
     [wau_horizontal_alignment_cbb.currentIndexChanged],
     [wau_vertical_alignment_cbb.currentIndexChanged],
    ].each { 
      it[0].connect this, "waon_update_output_bn(Object)"
    }

    def mav_r = 0 // row
    [[wau_io_pn_l, mav_r, 0, 1, 1, mau_align_right],
     [wau_io_pn_le, mav_r, 1, 1, 3],
     [wau_input_fn_pb, mav_r++, 4, 2, 1],
     [wau_input_bn_l, mav_r, 0, 1, 1, mau_align_right],
     [wau_input_bn_le, mav_r++, 1, 1, 3],
     [wau_input_fl_info_l, mav_r, 0, 1, 1, mau_align_right],
     [wau_input_fl_info_le, mav_r++, 1, 1, -1],
     [wam_create_horizontal_line(), mav_r++, 0, 1, -1],
     [wau_settings_l, mav_r++, 0, 1, 1, mau_align_right],
     [wau_output_bn_l, mav_r, 0, 1, 1, mau_align_right],
     [wau_output_bn_le, mav_r++, 1, 1, -1],
     [wam_create_horizontal_line(), mav_r++, 0, 1, -1],
     [wau_processing_l, mav_r, 0, 1, 1, mau_align_right],
     [wau_processing_pgb, mav_r, 1, 1, 2],
     [wau_resize_pb, mav_r++, 3, 1, -1, mau_align_center],
     [wau_log_te, mav_r++, 1, 1, -1],
    ].each { 
      wau_main_gl.addWidget it 
      if(it[0] == wau_settings_l) {
        wau_main_gl.addLayout wau_settings_hbl, it[1], 1, 1, -1
      }
    }
    wau_main_gl.with {
      setColumnStretch(1, 1)
    }
    wau_input_fn_pb.clicked.connect(this, "waon_input_fn_pb_clicked(Object)")
    wagn_input_fl_choosed.connect(this, "waon_input_fl_choosed(Object)")
    wau_resize_pb.clicked.connect(this, "waon_resize_pb_clicked(Object)")

    final def mau_window = new QWidget()
    mau_window.setLayout wau_main_gl
    setCentralWidget mau_window
    setWindowTitle WUSC_TITLE
  }
  private void waon_input_fn_pb_clicked(final x_checked) {
    final def nau_ifn = QFileDialog.getOpenFileName(this, "PDF 파일 선택", wau_io_pn_le.text(),  new QFileDialog.Filter("PDF 파일 (*.pdf)"))
    if(! nau_ifn) return
    wagn_input_fl_choosed.emit(nau_ifn)
  }
  private void waon_input_fl_choosed(final x_fn) {
    final def nau_ifi = new QFileInfo(x_fn)
    setWindowTitle "${WUSC_TITLE} : ${nau_ifi.fileName()}"
    wau_io_pn_le.setText(nau_ifi.absolutePath())
    wau_input_bn_le.setText(nau_ifi.fileName())

    wau_input_fl_info_le.setText ""
    final def nau_reader = new text.pdf.PdfReader(x_fn)
    final def nau_1st_page_size = nau_reader.getCropBox(1)
    final def nau_1st_page_rotation = nau_reader.getPageRotation(1)

    final def nau_total_pages = nau_reader.getNumberOfPages()
    if(nau_1st_page_rotation in [90, 270]) {
      wau_to_size_width_mm_dsb.setValue text.Utilities.pointsToMillimeters(nau_1st_page_size.getHeight()).round(1)
      wau_to_size_height_mm_dsb.setValue text.Utilities.pointsToMillimeters(nau_1st_page_size.getWidth()).round(1)
    } else {
      wau_to_size_width_mm_dsb.setValue text.Utilities.pointsToMillimeters(nau_1st_page_size.getWidth()).round(1)
      wau_to_size_height_mm_dsb.setValue text.Utilities.pointsToMillimeters(nau_1st_page_size.getHeight()).round(1)
    }
    final def nau_fmt = new DecimalFormat("0.0")
    wau_input_fl_info_le.setText "총 ${nau_total_pages} 페이지, 첫 페이지 크기 (${nau_fmt.format(wau_to_size_width_mm_dsb.value())} ⅹ ${nau_fmt.format(wau_to_size_height_mm_dsb.value())}) mm"
  }
  private void waon_update_output_bn(final x_arg) {
    [wau_binding_l, wau_binding_cbb].each { it.setEnabled wau_is_duplex_chb.isChecked() }
    def nav_is_invalid = false
    if(! wau_input_bn_le.text()) nav_is_invalid = true
    if(wau_to_size_width_mm_dsb.value() < WUSC_MINIMUM_LENGTH_MM) nav_is_invalid = true
    if(wau_to_size_height_mm_dsb.value() < WUSC_MINIMUM_LENGTH_MM) nav_is_invalid = true
    if(nav_is_invalid) {
      wau_output_bn_le.setText ""
      wau_resize_pb.setEnabled false
      return
    }
    final def nau_ifi = new QFileInfo(wau_input_bn_le.text())
    final def nau_fmt = new DecimalFormat("0.0")
    final def nau_size = "${nau_fmt.format(wau_to_size_width_mm_dsb.value())}ⅹ${nau_fmt.format(wau_to_size_height_mm_dsb.value())}"
    final def nau_plex = wau_is_duplex_chb.isChecked() ? "양면${wau_binding_cbb.currentText()}" : "단면"
    final def nau_alignment = "${wau_horizontal_alignment_cbb.currentText()}${wau_vertical_alignment_cbb.currentText()}"
    wau_output_bn_le.setText "${nau_ifi.completeBaseName()}.(${nau_size})mm.($nau_alignment).($nau_plex).${nau_ifi.suffix()}"
    wau_resize_pb.setEnabled true
  }
  private void waon_resize_pb_clicked(final x_checked) {
    wan_clear_log()
    wau_processing_pgb.setValue 0
    final def nau_ifn = "${wau_io_pn_le.text()}/${wau_input_bn_le.text()}"
    final def nau_ofn = "${wau_io_pn_le.text()}/${wau_output_bn_le.text()}"

    wan_log_info "입력 파일명 : <${wau_input_bn_le.text()}>"
    wan_log_info "저장 파일명 : <${wau_output_bn_le.text()}>"
    if(new QFileInfo(nau_ofn).exists()) {
      final def bau_r = QMessageBox.question(
        this, WUSC_TITLE, 
        "생성할 파일이 존재합니다. 겹쳐쓰겠습니까?", 
        new QMessageBox.StandardButtons(QMessageBox.StandardButton.Ok, QMessageBox.StandardButton.Cancel)
      )
      if(bau_r == QMessageBox.StandardButton.Cancel) return
    }

    final float nau_to_size_width_mm = wau_to_size_width_mm_dsb.value()
    final float nau_to_size_height_mm = wau_to_size_height_mm_dsb.value()
    final float nau_to_size_width_pt = text.Utilities.millimetersToPoints(nau_to_size_width_mm)
    final float nau_to_size_height_pt = text.Utilities.millimetersToPoints(nau_to_size_height_mm)
    final def nau_is_duplex = wau_is_duplex_chb.isChecked()
    final def nau_binding = wau_binding_cbb.with { itemData(currentIndex()) }
    final def nau_horizontal_alignment = wau_horizontal_alignment_cbb.with { itemData(currentIndex()) }
    final def nau_vertical_alignment = wau_vertical_alignment_cbb.with { itemData(currentIndex()) }

    wan_log_info "변경할 페이지 크기 : (${nau_to_size_width_mm} ⅹ ${nau_to_size_height_mm}) mm = (${nau_to_size_width_pt} ⅹ ${nau_to_size_height_pt}) pt"
    wan_log_info "양면 처리? : ${nau_is_duplex ? '예' : '아니오'}"
    if(nau_is_duplex) { wan_log_info "바인딩 : ${wau_binding_cbb.currentText()}(${nau_binding})" }
    wan_log_info "수평배치 : ${wau_horizontal_alignment_cbb.currentText()}(${nau_horizontal_alignment}), 수직배치 : ${wau_vertical_alignment_cbb.currentText()}(${nau_vertical_alignment})"

    final def nau_document = new text.Document(new text.Rectangle(nau_to_size_width_pt, nau_to_size_height_pt))

    def narp_do_it = {
      final def pau_writer = text.pdf.PdfWriter.getInstance(nau_document, new FileOutputStream(nau_ofn))
      nau_document.open()
      final def pau_canvas = pau_writer.getDirectContent()
      final def pau_reader = new text.pdf.PdfReader(nau_ifn)

      pau_writer.setOutputIntents(pau_reader, false)
      final def pau_total_pages = pau_reader.getNumberOfPages()
      wau_processing_pgb.setMaximum pau_total_pages
      wan_log_info "총 페이지 갯수 : ${pau_total_pages}\n"
      def parf2_get_alignment = { fx2_is_back ->
        def fav2_horizontal_alignment
        def fav2_vertical_alignment
        if(! fx2_is_back) {
          fav2_horizontal_alignment = nau_horizontal_alignment
          fav2_vertical_alignment = nau_vertical_alignment
        } else {
          if(nau_binding == DDocument.DBinding.DUSC_LEFT) {
            switch(nau_horizontal_alignment) {
              case Qt.AlignmentFlag.AlignLeft:
                fav2_horizontal_alignment = Qt.AlignmentFlag.AlignRight
                break
              case Qt.AlignmentFlag.AlignRight:
                fav2_horizontal_alignment = Qt.AlignmentFlag.AlignLeft
                break
              default:
                fav2_horizontal_alignment = Qt.AlignmentFlag.AlignCenter
                break
            }
            fav2_vertical_alignment = nau_vertical_alignment
          } else {
            fav2_horizontal_alignment = nau_horizontal_alignment
            switch(nau_vertical_alignment) {
              case Qt.AlignmentFlag.AlignTop:
                fav2_vertical_alignment = Qt.AlignmentFlag.AlignBottom
                break
              case Qt.AlignmentFlag.AlignBottom:
                fav2_vertical_alignment = Qt.AlignmentFlag.AlignTop
                break
              default:
                fav2_vertical_alignment = Qt.AlignmentFlag.AlignCenter
                break
            }
          }
        }
        return [fav2_horizontal_alignment, fav2_vertical_alignment]
      }
      def parf2_get_info = { fx2_page_idx, fx2_is_back ->
        final def (fau2_horizontal_alignment, fau2_vertical_alignment) = parf2_get_alignment(fx2_is_back)
        final def fau2_rotation = pau_reader.getPageRotation(fx2_page_idx)
        final def fau2_is_width_height_changed = fau2_rotation in [90, 270]
        final def fau2_page_size = pau_reader.getCropBox(fx2_page_idx)
        final float fau2_width_pt = fau2_is_width_height_changed ? fau2_page_size.getHeight() : fau2_page_size.getWidth()
        final float fau2_height_pt = fau2_is_width_height_changed ? fau2_page_size.getWidth() : fau2_page_size.getHeight()
        final float fau2_left_pt = fau2_page_size.getLeft()
        final float fau2_bottom_pt = fau2_page_size.getBottom()

        def fav2_affine_transform
        float fav2_offset_x
        float fav2_offset_y

        def fav2_x_shift_to_0_pt, fav2_y_shift_to_0_pt
        switch(fau2_rotation) {
          case 0:
            fav2_affine_transform = [1, 0, 0, 1]
            fav2_x_shift_to_0_pt = - fau2_left_pt
            fav2_y_shift_to_0_pt = - fau2_bottom_pt
            break
          case 90:
            fav2_affine_transform = [0, -1, 1, 0]
            fav2_x_shift_to_0_pt = - fau2_bottom_pt
            fav2_y_shift_to_0_pt = fau2_left_pt + fau2_height_pt
            break
          case 180:
            fav2_affine_transform = [-1, 0, 0, -1]
            fav2_x_shift_to_0_pt = fau2_left_pt + fau2_width_pt
            fav2_y_shift_to_0_pt = fau2_bottom_pt + fau2_height_pt
            break
          case 270:
            fav2_affine_transform = [0, 1, -1, 0]
            fav2_x_shift_to_0_pt = fau2_bottom_pt + fau2_width_pt
            fav2_y_shift_to_0_pt = - fau2_left_pt
            break
        }

        switch(fau2_horizontal_alignment) {
          case Qt.AlignmentFlag.AlignLeft:
            fav2_offset_x = fav2_x_shift_to_0_pt
            break
          case Qt.AlignmentFlag.AlignRight:
            fav2_offset_x = fav2_x_shift_to_0_pt + (nau_to_size_width_pt - fau2_width_pt)
            break
          default:
            fav2_offset_x = fav2_x_shift_to_0_pt + (nau_to_size_width_pt - fau2_width_pt) / 2.0f
            break
        }
        switch(fau2_vertical_alignment) {
          case Qt.AlignmentFlag.AlignTop:
            fav2_offset_y = fav2_y_shift_to_0_pt + (nau_to_size_height_pt - fau2_height_pt)
            break
          case Qt.AlignmentFlag.AlignBottom:
            fav2_offset_y = fav2_y_shift_to_0_pt
            break
          default:
            fav2_offset_y = fav2_y_shift_to_0_pt + (nau_to_size_height_pt - fau2_height_pt) / 2.0f
            break
        }
        final float fau2_width_mm = text.Utilities.pointsToMillimeters(fau2_width_pt)
        final float fau2_height_mm = text.Utilities.pointsToMillimeters(fau2_height_pt)
        wan_log_info "${fx2_page_idx} 페이지 : (${fau2_width_pt} ⅹ ${fau2_height_pt}) pt = (${fau2_width_mm} ⅹ ${fau2_height_mm}) mm"
        fav2_affine_transform.addAll([fav2_offset_x, fav2_offset_y])
        return [fau2_page_size, fav2_affine_transform]
      }
      (1..pau_total_pages).each { bx_page_idx ->
        wau_processing_pgb.setValue bx_page_idx
        final def bau_is_even = bx_page_idx % 2 == 0
        final def (bau_page_size, bau_affine_transform) = parf2_get_info(bx_page_idx, nau_is_duplex && bau_is_even) 
        nau_document.newPage()
        final def bau_page = pau_writer.getImportedPage(pau_reader, bx_page_idx)
        bau_page.setBoundingBox(bau_page_size)
        pau_canvas.addTemplate(bau_page, *bau_affine_transform)
      }
      wan_log_info "\n>\n>>\n>>> 완료 했습니다\n>>\n>"
    }
    try {
      narp_do_it()
    } catch(final bau_ex) {
      wan_log_error "*" * 100
      wan_log_error "* 다음 에러 발생 !!!"
      wan_log_error "*" * 100
      wan_log_error bau_ex.toString()
    } finally {
      nau_document.close()
    }
  }
  private def wan_clear_log() {
    wau_log_te.clear()
  }
  private def wan_log_info(final x_message) {
    wau_log_te.append(x_message)
    QApplication.processEvents()
  }
  private def wan_log_error(final x_message) {
    wau_log_te.append("<font color=red>${x_message}</font>")
    QApplication.processEvents()
  }
}

class CApp extends QObject {
  void cun_main(final x_args) {
    final def narp_init = { // r means closu(r)e
      println "OS => ${System.getProperty("os.name")}"
      println "File separator => ${File.separator}"
      println "Path separator => ${File.pathSeparator}"
      println "Arguments: ${x_args}"
      println()
    }
    final def narp_body = {
      QApplication.initialize(x_args as String[])
      final pau2_w = new WMain()
      pau2_w.show()
      pau2_w.raise()
      QApplication.execStatic()
    }
    final def narp_fini = { 
      System.exit(0) 
    }
    try {
      narp_init()
      narp_body()
      narp_fini()
    } catch(final bau_ex) {
      println "*" * 100
      println "* Following error occurs !!!"
      println "*" * 100
      bau_ex.printStackTrace(System.out)
      JOptionPane.showMessageDialog(
        null, 
        "어플리케이션 에러:\n\n${bau_ex.getMessage()}\n\n" + bau_ex.getStackTrace().join("\n"), 
        WMain.WUSC_TITLE, JOptionPane.ERROR_MESSAGE
      )
      System.exit(1)
    }
    println "*" * 100
  }
}


