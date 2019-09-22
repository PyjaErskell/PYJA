import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.lang.NullPointerException;
import java.lang.Thread;
import java.lang.Runnable;
import java.util.Date;
import javax.script.ScriptEngine;
import javax.script.ScriptEngineManager;

public class ORun implements Runnable {
  public static Date ol_st = new Date ();
  public static ScriptEngine ol_na;
  public static String ou_na_fn = System .getenv ("SC_TONO_HM") + File.separator + "SToa.js";
  public static String [] ol_args; 
  public static void main ( final String [] x_args ) throws Exception {
    ol_args = x_args;
    Thread nu_th1 = new Thread ( new ORun () );
    Thread nu_th2 = new Thread ( new ORun () );
    nu_th1 .start ();
    nu_th2 .start ();
    nu_th1 .join ();
    nu_th2 .join ();
  }
  public void run () {
    try {
      __oan_run_nashorn_script ();
    } catch ( Exception bu2_ex ) {} 
  }
  private static void __oan_run_nashorn_script () throws Exception {
    final File nu_fl = new File (ou_na_fn);
    if ( ! ( nu_fl .exists () && nu_fl .isFile () ) ) { throw new FileNotFoundException ( "Nashorn script file not found => " + ou_na_fn ); }
    ol_na = new ScriptEngineManager () .getEngineByName ("Nashorn");
    if ( ol_na == null ) { { throw new NullPointerException ( "Nashorn script engine not found !!!" ); } }
    ol_na .eval ( "load ('" + ou_na_fn .replaceAll ( "\\\\", "\\\\\\\\" ) + "');" );
  }
}
