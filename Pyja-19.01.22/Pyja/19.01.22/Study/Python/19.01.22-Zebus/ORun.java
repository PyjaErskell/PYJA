import java.io.File;
import java.io.FileNotFoundException;
import java.lang.ClassLoader;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.net.URL;
import java.net.URLClassLoader;
import javafx.application.Application;
import javafx.stage.Stage;
import javax.script.Invocable;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;
import jep.Jep;

public class ORun extends Application {
  private static String [] __oal_args; 
  public static void main ( final String [] x_args ) {
    __oal_args = x_args;
    if ( __oal_args.length < 1 ) {
      System.out.println ( "Must specify a Python file name !!!" );
      System .exit (1);
    }
    launch (ORun.class);
  }
  @Override
  public void start ( final Stage x_stage ) throws Exception {
    final Jep nu_jep = new Jep ( false, "." );
    nu_jep .set ( "JC_JEP", nu_jep );
    nu_jep .set ( "JC_FX_STAGE", x_stage );
    nu_jep .runScript ( __oal_args [0] );
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
