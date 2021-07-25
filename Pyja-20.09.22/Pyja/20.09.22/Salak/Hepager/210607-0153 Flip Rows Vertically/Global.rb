# +-----------------------------------------------------------------------+
# :                                 Pyja                                  :
# :                    https://github.com/PyjaErskell                     :
# :               made by Erskell (pyja.erskell@gmail.com)                :
# :  released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.  :
# +-----------------------------------------------------------------------+

$GC_FOSA = File::ALT_SEPARATOR || File::SEPARATOR # (fo)lder (s)ep(a)rator
$GC_PASA = File::PATH_SEPARATOR # (pa)th (s)ep(a)rator

$gf_pj = -> ( * x_args ) { x_args .join $GC_FOSA } # (p)ath (j)oin
$gf_xi = -> (x_it) { File .exist? x_it } # e(xi)sts

$gp_set_os_env = -> ( x_key, x_val ) { ENV[x_key] = x_val }
$gf_os_env = -> (x_key) {
  fu_r = ENV[x_key]
  raise  "Can't find environment variable => #{x_key} !!!" if fu_r.nil?
  fu_r
}

$GC_KAPA_HM = $gf_pj .( 'C:', 'ProgramData', 'Bichon Frise', 'Kapa' )

$GC_JAVA_HM = $gf_pj .( $GC_KAPA_HM, '19.11.01', 'Vindue', 'x64', 'Amazon', 'Corretto', '8.232.09.1' )
$gp_set_os_env .( 'JAVA_HOME', $GC_JAVA_HM )

$GC_PYTHON_HM = $gf_pj .( $GC_KAPA_HM, '19.01.22', 'Vindue', 'x64', 'Anaconda', '5.1.0' )
$GC_JEP_PN = $gf_pj .( $GC_PYTHON_HM, 'Lib', 'site-packages', 'jep' )
$GC_JEP_JAR_FN = $gf_pj . ( $GC_JEP_PN, 'jep-3.7.1.jar' )
$GC_QT_PLUGIN_PATH = $gf_pj . ( $GC_PYTHON_HM, 'Library', 'plugins' )

$gp_set_os_env .( 'Path', ( [ $GC_PYTHON_HM, $gf_os_env .('Path') ] .join $GC_PASA ) )
$gp_set_os_env .( 'PYTHONPATH', ( [ $gf_pj .( $GC_PYTHON_HM, 'Lib' ), $gf_pj .( $GC_PYTHON_HM, 'DLLs' ) ] .join $GC_PASA ) )

require 'rjb'

-> () {
  pu_jar_list = [
    $gf_pj .( $GC_KAPA_HM, '19.11.01', 'Cumuni', 'Groovy', '3.0.8', 'indy', 'groovy-3.0.8-indy.jar' ),
    $gf_pj .( $GC_KAPA_HM, '19.11.01', 'Cumuni', 'Groovy', '3.0.8', 'indy', 'groovy-jsr223-3.0.8-indy.jar' ),
    $GC_JEP_JAR_FN,
  ]
  pu_jar_list .each { |bu2_jar_fn| raise "Can't find jar file => #{bu2_jar_fn}" unless $gf_xi .(bu2_jar_fn) }
  Rjb::load ( pu_jar_list .join $GC_PASA ), [ '-Dfile.encoding=UTF-8', "-Djava.library.path=#{$GC_JEP_PN}" ]
} .()

-> () {
  $gu_t = ( Rjb::import 'jep.Jep' ).new false, $GC_TONO_HM
  $gu_t .set 'SC_QT_PLUGIN_PATH', $GC_QT_PLUGIN_PATH
  $gu_t .set 'SC_TONO_HM', $GC_TONO_HM
  $gu_t .runScript $gf_pj .( $GC_TONO_HM, 'SToa.py' )
} .()
$gf_tf = -> ( x_nm, * x_args ) { $gu_t .invoke x_nm.to_s, x_args } # tf = py(t)hon (f)unction

$gp_do = -> (x_xml_params_fn) { $gf_tf .( 'gp_do', x_xml_params_fn ) }
