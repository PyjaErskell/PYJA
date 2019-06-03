import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.lang.ClassLoader;
import java.lang.NullPointerException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.Date;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import javax.script.Invocable;

public class ORun {
  public static Date ol_st = new Date ();
  public static ScriptEngine ol_gr;
  public static String [] ol_args; 
  public static void main ( final String [] x_args ) throws Exception {
    ol_args = x_args;
    ol_gr = new ScriptEngineManager () .getEngineByName ("Groovy");
    if ( ol_gr == null ) { { throw new NullPointerException ( "Groovy script engine not found !!!" ); } }
    on_run_script ( ol_gr, System .getenv ("SC_TONO_HM") + File.separator + "SToa.groovy" );
    final Invocable nu_gi = (Invocable) ol_gr;
    try {
      SToa .sp_main (ol_gr);
    } catch ( final Exception bu2_ex ) {
      final Object bu2_ex_list = nu_gi .invokeFunction ( "gf_exception_to_list", new Object [] {bu2_ex} );
      nu_gi .invokeFunction ( "gp_request_exit", new Object [] { ol_gr .get ("GC_EC_ERROR"), bu2_ex_list } );
    }
  }
  public static void on_run_script ( final ScriptEngine x_se, final String x_fn ) throws Exception {
    final File nu_fl = new File (x_fn);
    if ( ! ( nu_fl .exists () && nu_fl .isFile () ) ) { throw new FileNotFoundException ( "Script file not found => " + x_fn ); }
    ol_gr .eval ( new FileReader (nu_fl) );
  }
  public static void on_add_jar ( final String x_jar_fn ) throws Exception {
    final File nu_jar_fl = new File (x_jar_fn);
    if ( ! ( nu_jar_fl .exists () && nu_jar_fl .isFile () ) ) { throw new FileNotFoundException ( "JAR file not found => " + x_jar_fn ); }
    final URL nu_url = nu_jar_fl .toURI () .toURL ();
    final URLClassLoader nu_cl = (URLClassLoader) ClassLoader .getSystemClassLoader ();
    final Method nu_m = URLClassLoader.class .getDeclaredMethod ( "addURL", URL.class );
    nu_m .setAccessible (true);
    nu_m .invoke ( nu_cl, nu_url );
  }
  public static void on_add_java_library_path ( final String x_java_library_pn ) throws Exception {
    final File nu_library_ph = new File (x_java_library_pn);
    if ( ! ( nu_library_ph .exists () && nu_library_ph .isDirectory () ) ) { throw new FileNotFoundException ( "Java library path not found => " + x_java_library_pn ); }
    final String nu_org_paths = System .getProperty ( "java.library.path" );
    System .setProperty ( "java.library.path", nu_org_paths + File.pathSeparator + x_java_library_pn );
    final Field nu_f = ClassLoader.class .getDeclaredField ("sys_paths");
    nu_f .setAccessible (true);
    nu_f .set (null, null);
  }
}
