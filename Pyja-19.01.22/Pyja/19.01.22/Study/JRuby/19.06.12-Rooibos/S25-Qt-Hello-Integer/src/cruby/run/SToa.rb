require 'rjb'

-> () {
  $gp_set_os_env .( 'SC_VBS_FN', $GC_VBS_FN )
  $gp_set_os_env .( 'SC_KAPA_HM', $GC_KAPA_HM )

  pu_milo_pn = $gf_ap .( $gf_pj .( $GC_TONO_HM, '..' ) )
  pu_pyja_hm = $gf_ap .( $gf_pj .( pu_milo_pn, '..', '..', '..' ) )
  pu_pyja_rt = $gf_ap .( $gf_pj .( pu_pyja_hm, '..' ) )

  $gp_set_os_env .( 'SC_TONO_HM', $GC_TONO_HM )
  $gp_set_os_env .( 'SC_MILO_PN', pu_milo_pn )
  $gp_set_os_env .( 'SC_PYJA_HM', pu_pyja_hm )
  $gp_set_os_env .( 'SC_PYJA_RT', pu_pyja_rt )

  $gp_set_os_env .( 'SC_PYJA_NM', $gf_bn .(pu_pyja_rt) )
  $gp_set_os_env .( 'SC_PYJA_VR', $gf_bn .(pu_pyja_hm) )

  $gp_set_os_env .( 'JAVA_HOME', $GC_JAVA_HM )
  $gp_set_os_env .( 'SC_J8_HM', $GC_JAVA_HM )
  pu_jruby_hm = $gf_pj .( $GC_KAPA_HM, '19.01.22', 'Cumuni', 'JRuby', '9.2.5.0' )
  $gp_set_os_env .( 'JRUBY_HOME', pu_jruby_hm )

  $gp_set_os_env .( 'SC_PATH', $gf_os_env .('Path') )

  pu_java_x_fn = $gf_pj .( $GC_JAVA_HM, 'bin', 'java.exe' )
  raise "Can't find java.exe => #{pu_java_x_fn}" unless $gf_xi .(pu_java_x_fn)
  pu_jar_list = [
    $gf_pj .( $GC_TONO_HM, 'ecu', 'ORun.jar' ),
    $gf_pj .( $GC_KAPA_HM, '19.01.22', 'Cumuni', 'Akka', '2.5.19', 'akka-actor_2.12-2.5.19.jar' ),
    $gf_pj .( $GC_KAPA_HM, '19.01.22', 'Cumuni', 'Groovy', '2.5.5', 'indy', 'groovy-2.5.5-indy.jar' ),
    $gf_pj .( $GC_KAPA_HM, '19.01.22', 'Cumuni', 'Groovy', '2.5.5', 'indy', 'groovy-jsr223-2.5.5-indy.jar' ),
    $gf_pj .( $GC_KAPA_HM, '19.01.22', 'Cumuni', 'Scala', '2.12.8', 'lib', 'scala-library.jar' ),
    $gf_pj .( pu_jruby_hm, 'lib', 'jruby.jar' ),
    $gf_pj .( $GC_KAPA_HM, '19.01.22', 'Vindue', 'x64', 'QtJambi', '4.8.7', 'qtjambi-4.8.7.jar' ),
  ]
  pu_jar_list .each { |bu2_jar_fn| raise "Can't find jar file => #{bu2_jar_fn}" unless $gf_xi .(bu2_jar_fn) }
  pu_lp_list = [
    $gf_pj .( $GC_TONO_HM, 'ecu' ),
    $gf_pj .( $GC_KAPA_HM, '19.01.22', 'Vindue', 'x64', 'QtJambi', '4.8.7', 'qtjambi-native-win64-msvc2013x64-4.8.7', 'lib' ),
  ]
  pu_lp_list .each { |bu2_lib_pn| raise "Can't find library path => #{bu2_lib_pn}" unless $gf_xi .(bu2_lib_pn) }
  Rjb::load ( pu_jar_list .join $GC_PASA ), [ '-Dfile.encoding=UTF-8', "-Djava.library.path=#{ pu_lp_list .join $GC_PASA }" ]
  ( Rjb::import 'ORun' ) .main ( [] )
} .()
