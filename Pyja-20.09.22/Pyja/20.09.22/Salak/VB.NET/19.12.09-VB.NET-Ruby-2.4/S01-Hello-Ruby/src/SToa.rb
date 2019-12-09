#---------------------------------------------------------------
# Global
#---------------------------------------------------------------

$GC_FOSA = File::ALT_SEPARATOR || File::SEPARATOR # (fo)lder (s)ep(a)rator
$GC_PASA = File::PATH_SEPARATOR # (pa)th (s)ep(a)rator

$gf_pj = -> ( * x_args ) { x_args .join $GC_FOSA } # (p)ath (j)oin
$gf_bn = -> (x_fn) { File .basename x_fn } # (b)ase (n)ame
$gf_id = -> (x_it) { File .directory? x_it } # (i)s (d)irectory
$gf_pn = -> ( x_it, x_chedk_id = false ) { ( x_chedk_id and ( $gf_id .(x_it) ) ) ? (x_it) : ( File .dirname x_it ) } # (p)ath (n)ame
$gf_on = -> ( x_it, x_chedk_id = false ) { $gf_bn .( $gf_pn .( x_it, x_chedk_id ) ) } # f(o)lder (n)ame

$GC_OLIM_PN = $gf_pn .($GC_MILO_PN)
$GC_OLIM_NM = $gf_on .( $GC_OLIM_PN, true )

$GC_TONO_HM = $GC_MILO_PN
$GC_TONO_NM = $gf_on .( $GC_TONO_HM, true )

$gf_sf = -> ( * x_args ) { sprintf *x_args } # (s)tring (f)ormat

#---------------------------------------------------------------
# Your Source
#---------------------------------------------------------------

