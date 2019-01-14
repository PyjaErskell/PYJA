import java.io.File;
import java.io.FileNotFoundException;
import java.lang.ClassLoader;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.net.URL;
import java.net.URLClassLoader;
import java.util.Date;
import javafx.application.Application;
import javafx.stage.Stage;
import javax.script.Invocable;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;

public class ORun extends Application {
  public static Date ol_st = new Date ();
  public static String [] ol_args; 
  public static Stage ol_fx_stage;
  public static void main ( final String [] x_args ) {
    ol_args = x_args;
    if ( ol_args.length < 1 ) {
      System.out.println ( "Must specify a JRuby file name !!!" );
      System .exit (1);
    }
    launch (ORun.class);
  }
  @Override
  public void start ( final Stage x_stage ) throws Exception {
    ol_fx_stage = x_stage;
    final ScriptEngine nu_jr = new ScriptEngineManager () .getEngineByName ("jruby");
    if ( nu_jr == null ) {
      System.out.println ( "Can't find JRuby engine !!!" );
      System .exit (1);
    }
    final String nu_jr_fn = ol_args [0];
    ( (Invocable) nu_jr ) .invokeFunction ( "require", nu_jr_fn );
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
