import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.lang.ClassLoader;
import java.lang.NullPointerException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.file.NotDirectoryException;
import java.util.Date;
import javafx.application.Application;
import javafx.stage.Stage;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;

public class ORun extends Application {
  public static Date ol_st = new Date ();
  public static Stage ol_ps;
  public static ScriptEngine ol_gr;
  public static String ou_gr_fn = System .getenv ("SC_TONO_HM") + File.separator + "SToa.groovy";
  public static String [] ol_args; 
  public static void main ( final String [] x_args ) throws Exception {
    ol_args = x_args;
    launch (ORun.class);
  }
  @Override
  public void start ( final Stage x_stage ) throws Exception {
    ol_ps = x_stage;
    __oan_run_groovy_script ();
  }
  private static void __oan_run_groovy_script () throws Exception {
    final File nu_fl = new File (ou_gr_fn);
    if ( ! ( nu_fl .exists () && nu_fl .isFile () ) ) { throw new FileNotFoundException ( "Groovy script file not found => " + ou_gr_fn ); }
    ol_gr = new ScriptEngineManager () .getEngineByName ("Groovy");
    if ( ol_gr == null ) { { throw new NullPointerException ( "Groovy script engine not found !!!" ); } }
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
    if ( ! ( nu_library_ph .exists () && nu_library_ph .isDirectory () ) ) { throw new NotDirectoryException ( "Java library path not found => " + x_java_library_pn ); }
    final String nu_org_paths = System .getProperty ( "java.library.path" );
    System .setProperty ( "java.library.path", nu_org_paths + File.pathSeparator + x_java_library_pn );
    final Field nu_f = ClassLoader.class .getDeclaredField ("sys_paths");
    nu_f .setAccessible (true);
    nu_f .set ( null, null );
  }
}
