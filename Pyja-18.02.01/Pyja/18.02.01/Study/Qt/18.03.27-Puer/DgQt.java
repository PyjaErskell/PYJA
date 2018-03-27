public class DgQt {
  static { System.loadLibrary ("DgQt"); }

  public final static int DC_CT_AC  =    0; // Qt::AutoConnection
  public final static int DC_CT_DC  =    1; // Qt::DirectConnection
  public final static int DC_CT_QC  =    2; // Qt::QueuedConnection
  public final static int DC_CT_BQC =    3; // Qt::BlockingQueuedConnection
  public final static int DC_CT_UC  = 0x80; // Qt::UniqueConnection

  public native static void dp_i0  ( final long x_qo, final String x_mn, final int x_ct );
  public native static void dp_i1  ( final long x_qo, final String x_mn, final int x_ct, final Object x_1 );
  public native static void dp_i2  ( final long x_qo, final String x_mn, final int x_ct, final Object x_1, final Object x_2 );
  public native static void dp_i3  ( final long x_qo, final String x_mn, final int x_ct, final Object x_1, final Object x_2, final Object x_3 );
  public native static void dp_i4  ( final long x_qo, final String x_mn, final int x_ct, final Object x_1, final Object x_2, final Object x_3, final Object x_4 );
  public native static void dp_i5  ( final long x_qo, final String x_mn, final int x_ct, final Object x_1, final Object x_2, final Object x_3, final Object x_4, final Object x_5 );
  public native static void dp_i6  ( final long x_qo, final String x_mn, final int x_ct, final Object x_1, final Object x_2, final Object x_3, final Object x_4, final Object x_5, final Object x_6 );
  public native static void dp_i7  ( final long x_qo, final String x_mn, final int x_ct, final Object x_1, final Object x_2, final Object x_3, final Object x_4, final Object x_5, final Object x_6, final Object x_7 );
  public native static void dp_i8  ( final long x_qo, final String x_mn, final int x_ct, final Object x_1, final Object x_2, final Object x_3, final Object x_4, final Object x_5, final Object x_6, final Object x_7, final Object x_8 );
  public native static void dp_i9  ( final long x_qo, final String x_mn, final int x_ct, final Object x_1, final Object x_2, final Object x_3, final Object x_4, final Object x_5, final Object x_6, final Object x_7, final Object x_8, final Object x_9 );
  public native static void dp_i10 ( final long x_qo, final String x_mn, final int x_ct, final Object x_1, final Object x_2, final Object x_3, final Object x_4, final Object x_5, final Object x_6, final Object x_7, final Object x_8, final Object x_9, final Object x_10 );
}
