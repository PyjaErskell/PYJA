# +-----------------------------------------------------------------------+
# :                                 Pyja                                  :
# :                    https://github.com/PyjaErskell                     :
# :               made by Erskell (pyja.erskell@gmail.com)                :
# :  released under the GNU AGPL v3, see <http://www.gnu.org/licenses/>.  :
# +-----------------------------------------------------------------------+

$GC_FOSA = File::ALT_SEPARATOR || File::SEPARATOR # (fo)lder (s)ep(a)rator
$GC_PASA = File::PATH_SEPARATOR # (pa)th (s)ep(a)rator

$GC_IS_WINDOWS = $GC_FOSA == '\\'

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

$gf_bn = -> (x_fn) { File .basename x_fn }
$gf_ap = -> (x_it) {
  fu_pn = File .expand_path x_it
  return ( fu_pn .gsub '/', '\\' ) if $GC_IS_WINDOWS
  fu_pn
}

$gp_set_os_env .( 'Path', $gf_pj .( $gf_os_env .('SystemRoot'), 'System32' )  )
