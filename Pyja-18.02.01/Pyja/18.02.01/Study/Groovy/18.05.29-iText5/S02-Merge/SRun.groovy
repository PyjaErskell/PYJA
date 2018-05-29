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

class WMain extends QMainWindow {
  final static def WUSC_TITLE = new File ( System.getenv().SC_MILO_PN ) .getName ()
  final static def WUSC_INPUT_TYPE_IS_FILE = 0
  final static def WUSC_INPUT_TYPE_IS_BLANK = 1
  private def wav_io_rescent_pn = new QDir("${System.getProperty("user.home")}${File.separator}Desktop").path()
  final private QSignalEmitter.Signal0 wagn_inputs_changed = new QSignalEmitter.Signal0(this)
  final private QSignalEmitter.Signal1<Object> wagn_input_fls_choosed = new QSignalEmitter.Signal1<Object>(this)
  final private def wau_main_gl = new QGridLayout()
  final private def wau_inputs_hbl = new QHBoxLayout()
  final private def wau_inputs_lw = new QListWidget().with { setMinimumWidth(650); setSelectionMode(QAbstractItemView.SelectionMode.ContiguousSelection); it }
  final private def wau_inputs_arrange_vbl = new QVBoxLayout()
  final private def wau_new_inputs_pb = new QPushButton("새목록")
  final private def wau_add_inputs_pb = new QPushButton("파일추가…")
  final private def wau_remove_inputs_pb = new QPushButton("삭제")
  final private def wau_up_inputs_pb = new QPushButton("위로")
  final private def wau_down_inputs_pb = new QPushButton("아래로")
  final private def wau_sort_inputs_pb = new QPushButton("정렬")
  final private def wau_exchange_front_and_rear_inputs_pb = new QPushButton("앞뒤교환")
  final private def wau_add_blanks_pb = new QPushButton("공백추가…")
  final private def wau_save_hbl = new QHBoxLayout()
  final private def wau_save_fn_le = new QLineEdit().with { setMinimumWidth(650); setAlignment(Qt.AlignmentFlag.AlignRight); readOnly = true; it }
  final private def wau_save_fn_pb = new QPushButton("…").with { setMaximumWidth(25); it }
  final private def wau_process_vbl = new QVBoxLayout()
  final private def wau_merge_hbl = new QHBoxLayout()
  final private def wau_merge_pgb = new QProgressBar().with { setAlignment(Qt.AlignmentFlag.AlignCenter); it }
  final private def wau_merge_pb = new QPushButton("병합").with { setMaximumWidth(80); it }
  final private def wau_log_te = new QTextEdit().with { setReadOnly true; setWordWrapMode QTextOption.WrapMode.NoWrap; setMinimumHeight 170; setMaximumHeight 200; it }
  WMain(final x_parent=null) {
    setParent(x_parent)

    [[wau_new_inputs_pb, "waon_new_inputs(Object)"],
     [wau_add_inputs_pb, "waon_add_inputs(Object)"],
     [wau_remove_inputs_pb, "waon_remove_inputs(Object)"],
     [wau_up_inputs_pb, "waon_up_inputs(Object)"],
     [wau_down_inputs_pb, "waon_down_inputs(Object)"],
     [wau_sort_inputs_pb, "waon_sort_inputs(Object)" ],
     [wau_exchange_front_and_rear_inputs_pb, "waon_exchange_front_and_rear_inputs(Object)" ],
     [wau_add_blanks_pb, "waon_add_blanks(Object)"],
    ].each { bx_button, bx_slot ->
      wau_inputs_arrange_vbl.with {
        addWidget(bx_button)
      }
      bx_button.clicked.connect(this, bx_slot)
    }
    wau_inputs_arrange_vbl.with {
      addItem(new QSpacerItem(1, 1, QSizePolicy.Policy.Minimum, QSizePolicy.Policy.Expanding))
    }
    wau_inputs_hbl.with {
      addWidget(wau_inputs_lw)
      addLayout(wau_inputs_arrange_vbl)
    }
    wau_save_hbl.with {
      addWidget(wau_save_fn_le)
      addWidget(wau_save_fn_pb)
    }
    wau_save_fn_pb.clicked.connect(this, "waon_get_save_fn(Object)")
    wau_merge_hbl.with {
      addWidget(wau_merge_pgb)
      addWidget(wau_merge_pb)
    }
    wau_merge_pb.clicked.connect(this, "waon_merge(Object)")
    wau_process_vbl.with {
      addLayout wau_merge_hbl
      addWidget wau_log_te
    }
    def mav_r = 0 // row
    [[new QLabel("입력목록"), mav_r, 0, 1, 1, [Qt.AlignmentFlag.AlignRight, Qt.AlignmentFlag.AlignTop] as Qt.AlignmentFlag[]],
     [wau_inputs_hbl, mav_r++, 1, 1, 1],
     [wam_create_horizontal_line(), mav_r++, 0, 1, -1],
     [new QLabel("저장파일"), mav_r, 0, 1, 1, [Qt.AlignmentFlag.AlignRight, Qt.AlignmentFlag.AlignCenter] as Qt.AlignmentFlag[]],
     [wau_save_hbl, mav_r++, 1, 1, 1],
     [wam_create_horizontal_line(), mav_r++, 0, 1, -1],
     [new QLabel("처리"), mav_r, 0, 1, 1, [Qt.AlignmentFlag.AlignRight, Qt.AlignmentFlag.AlignCenter] as Qt.AlignmentFlag[]],
     [wau_process_vbl, mav_r++, 1, 1, 1],
    ].each {
      if(it[0] instanceof QWidget) {
        wau_main_gl.addWidget it
      } else {
        wau_main_gl.addLayout it
      }
    }
    final def mau_window = new QWidget()
    mau_window.setLayout wau_main_gl
    setCentralWidget mau_window
    setWindowTitle WUSC_TITLE
    wagn_input_fls_choosed.connect(this, "waon_input_fls_choosed(Object)")
    wagn_inputs_changed.connect(this, "waon_inputs_or_selection_changed()")
    wau_inputs_lw.itemSelectionChanged.connect(this, "waon_inputs_or_selection_changed()")
    waon_inputs_or_selection_changed()
  }  
  private def wam_create_horizontal_line() {
    new QFrame(this).with {
      setGeometry new QRect(1, 1, 1, 1)
      setFrameShape QFrame.Shape.HLine
      setFrameShadow QFrame.Shadow.Sunken
      it
    }
  }
  private def wam_get_range_of_selected_rows() {
    final def mau_range = wau_inputs_lw.selectedIndexes().collect { it.row() }.sort()
    return [mau_range.first(), mau_range.last()]
  }
  private void waon_new_inputs(final x_checked) {
    try {
      final def bau_r = QMessageBox.question(
        this, WUSC_TITLE, 
        "입력목록을 지우고 다시 시작하겠습니까?", 
        new QMessageBox.StandardButtons(QMessageBox.StandardButton.Ok, QMessageBox.StandardButton.Cancel)
      )
      if(bau_r == QMessageBox.StandardButton.Cancel) { return }
      wau_inputs_lw.clear()
      wau_save_fn_le.clear()
      wau_merge_pgb.reset()
      wan_clear_log()
      wagn_inputs_changed.emit()
    } finally {
      wau_inputs_lw.setFocus()
    }
  }
  private void waon_add_inputs(final x_checked) {
    final def nau_ifns = QFileDialog.getOpenFileNames(this, "PDF 파일 선택", wav_io_rescent_pn,  new QFileDialog.Filter("PDF 파일 (*.pdf)"))
    if(! nau_ifns) return

    wagn_input_fls_choosed.emit(nau_ifns)
  }
  private void waon_remove_inputs(final x_checked) {
    try {
      final def bau_r = QMessageBox.question(
        this, WUSC_TITLE, 
        "선택한 목록을 삭제하겠습니까?", 
        new QMessageBox.StandardButtons(QMessageBox.StandardButton.Ok, QMessageBox.StandardButton.Cancel)
      )
      if(bau_r == QMessageBox.StandardButton.Cancel) { return }
      wau_inputs_lw.setEnabled false
      wau_inputs_lw.with {
        selectedItems().each { bx3_item -> takeItem row(bx3_item) }
        if(count() >= 1) currentItem().setSelected(true)
      }
      wagn_inputs_changed.emit()
      wau_inputs_lw.setEnabled true
    } finally {
      wau_inputs_lw.setFocus()
    }
  }
  private void waon_up_inputs(final x_checked) {
    try {
      wau_inputs_lw.with {
        final def bau2_row = row(selectedItems().first())
        final def bau2_item = takeItem bau2_row
        insertItem(bau2_row - 1, bau2_item)
        setCurrentItem bau2_item
      }
      wagn_inputs_changed.emit()
    } finally {
      wau_inputs_lw.setFocus()
    }
  }
  private void waon_down_inputs(final x_checked) {
    try {
      wau_inputs_lw.with {
        final def bau2_row = row(selectedItems().first())
        final def bau2_item = takeItem bau2_row
        insertItem(bau2_row + 1, bau2_item)
        setCurrentItem bau2_item
      }
      wagn_inputs_changed.emit()
    } finally {
      wau_inputs_lw.setFocus()
    }
  }
  private void waon_sort_inputs(final x_checked) {
    try {
      wau_inputs_lw.setEnabled false
      final def (bau_first, bau_last) = wam_get_range_of_selected_rows()
      final def bau_sorted = wau_inputs_lw.selectedItems().sort { it.data(Qt.ItemDataRole.DisplayRole) }
      wau_inputs_lw.with {
        // 1st, deleted existing items
        selectedItems().each { bx3_item -> takeItem row(bx3_item) }
        // 2nd, insert sorted items
        [(bau_first..bau_last), bau_sorted].transpose().each { bx3_row, bx3_item ->
          insertItem(bx3_row, bx3_item)
          bx3_item.setSelected true
        }
      }
      wagn_inputs_changed.emit()
      wau_inputs_lw.setEnabled true
    } finally {
      wau_inputs_lw.setFocus()
    }
  }
  private void waon_exchange_front_and_rear_inputs(final x_checked) {
    try {
      wau_inputs_lw.setEnabled false
      final def (bau_first, bau_last) = wam_get_range_of_selected_rows()
      for(def bav2_row = bau_first; bav2_row < bau_last; bav2_row += 2) {
        wau_inputs_lw.with {
          final def bau3_item = takeItem bav2_row
          insertItem(bav2_row + 1, bau3_item)
          bau3_item.setSelected true
        }
      }
      wagn_inputs_changed.emit()
      wau_inputs_lw.setEnabled true
    } finally {
      wau_inputs_lw.setFocus()
    }
  }
  private void waon_add_blanks(final x_checked) {
    final def narf_new_item = { final fx_total_pages, final fx_info_of_selected_row ->  
      final def fau_info = [:]
      fau_info.type = WUSC_INPUT_TYPE_IS_BLANK
      fau_info.total_pages = fx_total_pages
      fau_info.first_page_width_mm = fx_info_of_selected_row.first_page_width_mm
      fau_info.first_page_height_mm = fx_info_of_selected_row.first_page_height_mm

      final def fau_fmt = new DecimalFormat("0.0")
      final def fau_o = new QListWidgetItem("-- ${fx_total_pages}개 공백 페이지, (${fau_fmt.format(fau_info.first_page_width_mm)} ⅹ ${fau_fmt.format(fau_info.first_page_height_mm)}) mm --")
      fau_o.setData Qt.ItemDataRole.UserRole, fau_info
      wan_log_info "<공백 페이지> 추가 - 총 ${fau_info.total_pages} 페이지, 페이지 크기 (${fau_fmt.format(fau_info.first_page_width_mm)} ⅹ ${fau_fmt.format(fau_info.first_page_height_mm)}) mm"
      wan_log_info ""
      return fau_o
    }
    try {
      wau_inputs_lw.with {
        final def bau2_item = selectedItems().first()
        final def bau2_row = row(selectedItems().first())
        final def bau2_total_pages = QInputDialog.getInt(this, WUSC_TITLE, "공백 페이지 수 : ", 1, 1, 10000, 1)
        if(! bau2_total_pages) { return }
        final def bau2_o = narf_new_item(bau2_total_pages, selectedItems().first().data(Qt.ItemDataRole.UserRole))
        wau_inputs_lw.clearSelection()
        insertItem(bau2_row + 1, bau2_o)
        setCurrentItem bau2_o
      }
      wagn_inputs_changed.emit()
    } finally {
      wau_inputs_lw.setFocus()
    }
  }
  private void waon_get_save_fn(final x_checked) {
    final def nau_sfn = QFileDialog.getSaveFileName(this, "저장할 PDF 파일 명", wav_io_rescent_pn,  new QFileDialog.Filter("PDF 파일 (*.pdf)"))
    if(! nau_sfn) return
    wav_io_rescent_pn = new QFileInfo(nau_sfn).absolutePath()
    wau_save_fn_le.setText nau_sfn
  }
  private void waon_merge(final x_checked) {
    final def nau_sfn = wau_save_fn_le.text().trim()
    if(! nau_sfn) {
      QMessageBox.warning(this, WUSC_TITLE, "저장할 파일 이름을 지정하세요.")
      return
    }
    wan_goto_bottom_of_log()
    final def nau_total_inputs = wau_inputs_lw.count()
    wan_log_info "+--------------------------------------------------" 
    wan_log_info ": 총 ${nau_total_inputs}개의 입력에 대해 병합 시작 ...  "
    wan_log_info "+--------------------------------------------------" 
    final def nau_total_pages = {
      def bav_total = 0
      (0..<nau_total_inputs).each { bx2_row -> 
        bav_total += wau_inputs_lw.item(bx2_row).data(Qt.ItemDataRole.UserRole).total_pages 
      }
      return bav_total
    }()
    wau_merge_pgb.with { setValue 0; setMaximum nau_total_pages }
    wan_log_info "병합할 총 페이지 수 : ${nau_total_pages}"
    wan_log_info "생성할 파일명 : <${new QFileInfo(nau_sfn).fileName()}>"
    wan_log_info ""
    final def nau_document = new text.Document()
    def narp_new_page = {
      nau_document.with { isOpen() ? newPage() : open() }
    }
    def narp_do_it = {
      final def pau_writer = text.pdf.PdfWriter.getInstance(nau_document, new FileOutputStream(nau_sfn))
      nau_document.open()
      final def pau_canvas = pau_writer.getDirectContent()
      final pav_output_page_cnt = 0
      def parf2_get_info = { fx2_reader, fx2_page_idx ->
        final def fau2_rotation = fx2_reader.getPageRotation(fx2_page_idx)
        final def fau2_is_width_height_changed = fau2_rotation in [90, 270]
        final def fau2_page_size = fx2_reader.getCropBox(fx2_page_idx)
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
        fav2_offset_x = fav2_x_shift_to_0_pt
        fav2_offset_y = fav2_y_shift_to_0_pt
        final float fau2_width_mm = text.Utilities.pointsToMillimeters(fau2_width_pt)
        final float fau2_height_mm = text.Utilities.pointsToMillimeters(fau2_height_pt)
        wan_log_info "    page ${fx2_page_idx} : (${fau2_width_pt} ⅹ ${fau2_height_pt}) pt = (${fau2_width_mm} ⅹ ${fau2_height_mm}) mm"
        fav2_affine_transform.addAll([fav2_offset_x, fav2_offset_y])
        return [fau2_page_size, fav2_affine_transform]
      }
      (0..<nau_total_inputs).each { bx_row -> 
        final def bau_info = wau_inputs_lw.item(bx_row).data(Qt.ItemDataRole.UserRole)
        final def bav_reader
        if (bau_info.type == WUSC_INPUT_TYPE_IS_BLANK) {
          wan_log_info "입력 ${bx_row+1} : <${wau_inputs_lw.item(bx_row).text()}> 처리 ..."
        } else {
          wan_log_info "입력 ${bx_row+1} : <${new QFileInfo(bau_info.file_name).fileName()}> 처리 ..."
          bav_reader = new text.pdf.PdfReader(bau_info.file_name)
        }
        (1..bau_info.total_pages).each { bx2_page_idx ->
          pav_output_page_cnt++
          wau_merge_pgb.setValue pav_output_page_cnt
          if (bau_info.type == WUSC_INPUT_TYPE_IS_BLANK) {
            final float bau3_width_pt = text.Utilities.millimetersToPoints(bau_info.first_page_width_mm)
            final float bau3_height_pt = text.Utilities.millimetersToPoints(bau_info.first_page_height_mm)
            nau_document.setPageSize(new text.Rectangle(bau3_width_pt, bau3_height_pt))
            narp_new_page()
            pau_writer.setPageEmpty(false)
          } else {
            final def (bau3_page_size, bau3_affine_transform) = parf2_get_info(bav_reader, bx2_page_idx) 
            nau_document.setPageSize(bau3_page_size)
            narp_new_page()
            final def bau3_page = pau_writer.getImportedPage(bav_reader, bx2_page_idx)
            bau3_page.setBoundingBox(bau3_page_size)
            pau_canvas.addTemplate(bau3_page, *bau3_affine_transform)
          }
        }
        pau_writer.flush()
      }
      wan_log_info "\n병합한 결과를 저장중입니다\n데이타가 크면 오래 걸리 수 있습니다.\n기다리십시오 ...."
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
      wan_log_info "\n>\n>>\n>>> 완료 했습니다\n>>\n>"
    }
    wan_log_info ""
  }
  private def wam_get_pdf_info(final x_fn) {
    final def mau_reader = new text.pdf.PdfReader(x_fn)
    final def mau_1st_page_size = mau_reader.getCropBox(1)
    final def mau_1st_page_rotation = mau_reader.getPageRotation(1)

    final def mau_total_pages = mau_reader.getNumberOfPages()
    def mav_1st_page_width_mm
    def mav_1st_page_height_mm
    if(mau_1st_page_rotation in [90, 270]) {
      mav_1st_page_width_mm = text.Utilities.pointsToMillimeters(mau_1st_page_size.getHeight()).round(1)
      mav_1st_page_height_mm = text.Utilities.pointsToMillimeters(mau_1st_page_size.getWidth()).round(1)
    } else {
      mav_1st_page_width_mm = text.Utilities.pointsToMillimeters(mau_1st_page_size.getWidth()).round(1)
      mav_1st_page_height_mm = text.Utilities.pointsToMillimeters(mau_1st_page_size.getHeight()).round(1)
    }
    return [ mau_total_pages, mav_1st_page_width_mm, mav_1st_page_height_mm]
  }
  private void waon_input_fls_choosed(final x_fns) {
    final def narf_new_item = { final fx_fn ->  
      final def fau_bn = new QFileInfo(fx_fn).fileName()
      final def fau_o = new QListWidgetItem(fau_bn)
      final def ( fau_total_pages, fau_1st_page_width_mm, fau_1st_page_height_mm ) = wam_get_pdf_info(fx_fn)
      final def fau_info = [:]
      fau_info.type = WUSC_INPUT_TYPE_IS_FILE
      fau_info.file_name = fx_fn
      fau_info.total_pages = fau_total_pages
      fau_info.first_page_width_mm = fau_1st_page_width_mm
      fau_info.first_page_height_mm = fau_1st_page_height_mm
      fau_o.setData Qt.ItemDataRole.UserRole, fau_info
      final def fau_fmt = new DecimalFormat("0.0")
      wan_log_info "<${fau_bn}> - 총 ${fau_total_pages} 페이지, 첫 페이지 크기 (${fau_fmt.format(fau_1st_page_width_mm)} ⅹ ${fau_fmt.format(fau_1st_page_height_mm)}) mm"
      return fau_o
    }
    final nau_selected_total = wau_inputs_lw.selectedItems().size()
    try {
      def bav_row
      if(nau_selected_total == 1) {
        wau_inputs_lw.with { bav_row = row(wau_inputs_lw.selectedItems().first()) }
        final def bau2_r = QMessageBox.question(
          this, WUSC_TITLE, 
          "선택 항목의 이후에 추가 하겠습니까?\n이전에 추가려면 No를 클릭하세요.", 
          new QMessageBox.StandardButtons(QMessageBox.StandardButton.Yes, QMessageBox.StandardButton.No)
        )
        if(bau2_r == QMessageBox.StandardButton.Yes) { bav_row++ }
      }
      wav_io_rescent_pn = new QFileInfo(x_fns[0]).absolutePath()
      wau_inputs_lw.clearSelection()
      wan_log_info ""
      wan_log_info "+-------------------------------------------" 
      wan_log_info ": 총 ${x_fns.size()}개 파일 추가 ..."
      wan_log_info "+-------------------------------------------" 
      wau_inputs_lw.setEnabled false
      x_fns.each { bx2_fn ->
        final def bau2_o = narf_new_item(bx2_fn)
        if(nau_selected_total < 1) { wau_inputs_lw.addItem(bau2_o) }
        else { wau_inputs_lw.insertItem(bav_row++, bau2_o) }
        bau2_o.setSelected(true)
      }
      wan_log_info ""
      wan_log_info "총 ${x_fns.size()}개 파일 추가 완료"
      wan_log_info ""
      wagn_inputs_changed.emit()
      wau_inputs_lw.setEnabled true
    } finally {
      wau_inputs_lw.setFocus()
    }
  }
  private def waon_inputs_or_selection_changed() {
    final def nau_items_total = wau_inputs_lw.count()
    final def nau_selected_total = wau_inputs_lw.selectedItems().size()
    wau_new_inputs_pb.setEnabled nau_items_total >= 1
    wau_add_inputs_pb.setEnabled nau_selected_total <= 1
    wau_remove_inputs_pb.setEnabled nau_selected_total >= 1
    wau_save_fn_le.setEnabled nau_items_total >= 2
    wau_save_fn_pb.setEnabled nau_items_total >= 2
    wau_merge_pb.setEnabled nau_items_total >= 2
    wau_add_blanks_pb.setEnabled nau_selected_total == 1
    final def nau_condition_4_up_and_down = nau_items_total != nau_selected_total && nau_selected_total == 1
    wau_inputs_lw.with {
      wau_up_inputs_pb.setEnabled nau_condition_4_up_and_down && row(selectedItems().first()) > 0
      wau_down_inputs_pb.setEnabled nau_condition_4_up_and_down && row(selectedItems().first()) < nau_items_total -1
    }
    wau_sort_inputs_pb.setEnabled nau_selected_total > 1
    wau_exchange_front_and_rear_inputs_pb.setEnabled nau_selected_total > 1
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
  private def wan_goto_bottom_of_log() {
    wau_log_te.verticalScrollBar().with { setValue maximum() }
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


