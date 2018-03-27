#include "DgQt.h"

#include <QMetaObject>
#include <QCoreApplication>

auto jf_s ( JNIEnv * xtl_jnv, const jstring & xr_jstr ) { // get string from jstring
  jboolean fv_is_copy = false;
  const char * const ft_utf = xtl_jnv -> GetStringUTFChars ( xr_jstr, & fv_is_copy );
  const auto fu_qstr = QString (ft_utf);
  xtl_jnv -> ReleaseStringUTFChars ( xr_jstr, ft_utf );
  return fu_qstr;
}

JNIEXPORT void JNICALL Java_DgQt_dp_1i0  ( JNIEnv * xtl_jnv, jclass, jlong xl_qo, jstring xl_mn, jint xl_ct ) {
  const auto pt_qo = ( QObject * ) xl_qo;
  const auto pu_mn = jf_s ( xtl_jnv, xl_mn );
  const auto pu_ct = (int) xl_ct;
  QMetaObject::invokeMethod ( pt_qo, pu_mn .toStdString () .c_str (), (Qt::ConnectionType) pu_ct );
}

JNIEXPORT void JNICALL Java_DgQt_dp_1i1 ( JNIEnv * xtl_jnv, jclass, jlong xl_qo, jstring xl_mn, jint xl_ct, jobject xl_1 ) {
  const auto pt_qo = ( QObject * ) xl_qo;
  const auto pu_mn = jf_s ( xtl_jnv, xl_mn );
  const auto pu_ct = (int) xl_ct;
  QMetaObject::invokeMethod ( pt_qo, pu_mn .toStdString () .c_str (), (Qt::ConnectionType) pu_ct, Q_ARG ( jobject, xl_1 ) );
}

JNIEXPORT void JNICALL Java_DgQt_dp_1i2 ( JNIEnv * xtl_jnv, jclass, jlong xl_qo, jstring xl_mn, jint xl_ct, jobject xl_1, jobject xl_2 ) {
  const auto pt_qo = ( QObject * ) xl_qo;
  const auto pu_mn = jf_s ( xtl_jnv, xl_mn );
  const auto pu_ct = (int) xl_ct;
  QMetaObject::invokeMethod ( pt_qo, pu_mn .toStdString () .c_str (), (Qt::ConnectionType) pu_ct, Q_ARG ( jobject, xl_1 ), Q_ARG ( jobject, xl_2 ) );
}

JNIEXPORT void JNICALL Java_DgQt_dp_1i3 ( JNIEnv * xtl_jnv, jclass, jlong xl_qo, jstring xl_mn, jint xl_ct, jobject xl_1, jobject xl_2, jobject xl_3 ) {
  const auto pt_qo = ( QObject * ) xl_qo;
  const auto pu_mn = jf_s ( xtl_jnv, xl_mn );
  const auto pu_ct = (int) xl_ct;
  QMetaObject::invokeMethod ( pt_qo, pu_mn .toStdString () .c_str (), (Qt::ConnectionType) pu_ct, Q_ARG ( jobject, xl_1 ), Q_ARG ( jobject, xl_2 ), Q_ARG ( jobject, xl_3 ) );
}

JNIEXPORT void JNICALL Java_DgQt_dp_1i4 ( JNIEnv * xtl_jnv, jclass, jlong xl_qo, jstring xl_mn, jint xl_ct, jobject xl_1, jobject xl_2, jobject xl_3, jobject xl_4 ) {
  const auto pt_qo = ( QObject * ) xl_qo;
  const auto pu_mn = jf_s ( xtl_jnv, xl_mn );
  const auto pu_ct = (int) xl_ct;
  QMetaObject::invokeMethod ( pt_qo, pu_mn .toStdString () .c_str (), (Qt::ConnectionType) pu_ct, Q_ARG ( jobject, xl_1 ), Q_ARG ( jobject, xl_2 ), Q_ARG ( jobject, xl_3 ), Q_ARG ( jobject, xl_4 ) );
}

JNIEXPORT void JNICALL Java_DgQt_dp_1i5 ( JNIEnv * xtl_jnv, jclass, jlong xl_qo, jstring xl_mn, jint xl_ct, jobject xl_1, jobject xl_2, jobject xl_3, jobject xl_4, jobject xl_5 ) {
  const auto pt_qo = ( QObject * ) xl_qo;
  const auto pu_mn = jf_s ( xtl_jnv, xl_mn );
  const auto pu_ct = (int) xl_ct;
  QMetaObject::invokeMethod ( pt_qo, pu_mn .toStdString () .c_str (), (Qt::ConnectionType) pu_ct, Q_ARG ( jobject, xl_1 ), Q_ARG ( jobject, xl_2 ), Q_ARG ( jobject, xl_3 ), Q_ARG ( jobject, xl_4 ), Q_ARG ( jobject, xl_5 ) );
}

JNIEXPORT void JNICALL Java_DgQt_dp_1i6 ( JNIEnv * xtl_jnv, jclass, jlong xl_qo, jstring xl_mn, jint xl_ct, jobject xl_1, jobject xl_2, jobject xl_3, jobject xl_4, jobject xl_5, jobject xl_6 ) {
  const auto pt_qo = ( QObject * ) xl_qo;
  const auto pu_mn = jf_s ( xtl_jnv, xl_mn );
  const auto pu_ct = (int) xl_ct;
  QMetaObject::invokeMethod ( pt_qo, pu_mn .toStdString () .c_str (), (Qt::ConnectionType) pu_ct, Q_ARG ( jobject, xl_1 ), Q_ARG ( jobject, xl_2 ), Q_ARG ( jobject, xl_3 ), Q_ARG ( jobject, xl_4 ), Q_ARG ( jobject, xl_5 ), Q_ARG ( jobject, xl_6 ) );
}

JNIEXPORT void JNICALL Java_DgQt_dp_1i7 ( JNIEnv * xtl_jnv, jclass, jlong xl_qo, jstring xl_mn, jint xl_ct, jobject xl_1, jobject xl_2, jobject xl_3, jobject xl_4, jobject xl_5, jobject xl_6, jobject xl_7 ) {
  const auto pt_qo = ( QObject * ) xl_qo;
  const auto pu_mn = jf_s ( xtl_jnv, xl_mn );
  const auto pu_ct = (int) xl_ct;
  QMetaObject::invokeMethod ( pt_qo, pu_mn .toStdString () .c_str (), (Qt::ConnectionType) pu_ct, Q_ARG ( jobject, xl_1 ), Q_ARG ( jobject, xl_2 ), Q_ARG ( jobject, xl_3 ), Q_ARG ( jobject, xl_4 ), Q_ARG ( jobject, xl_5 ), Q_ARG ( jobject, xl_6 ), Q_ARG ( jobject, xl_7 ) );
}

JNIEXPORT void JNICALL Java_DgQt_dp_1i8 ( JNIEnv * xtl_jnv, jclass, jlong xl_qo, jstring xl_mn, jint xl_ct, jobject xl_1, jobject xl_2, jobject xl_3, jobject xl_4, jobject xl_5, jobject xl_6, jobject xl_7, jobject xl_8 ) {
  const auto pt_qo = ( QObject * ) xl_qo;
  const auto pu_mn = jf_s ( xtl_jnv, xl_mn );
  const auto pu_ct = (int) xl_ct;
  QMetaObject::invokeMethod ( pt_qo, pu_mn .toStdString () .c_str (), (Qt::ConnectionType) pu_ct, Q_ARG ( jobject, xl_1 ), Q_ARG ( jobject, xl_2 ), Q_ARG ( jobject, xl_3 ), Q_ARG ( jobject, xl_4 ), Q_ARG ( jobject, xl_5 ), Q_ARG ( jobject, xl_6 ), Q_ARG ( jobject, xl_7 ), Q_ARG ( jobject, xl_8 ) );
}

JNIEXPORT void JNICALL Java_DgQt_dp_1i9 ( JNIEnv * xtl_jnv, jclass, jlong xl_qo, jstring xl_mn, jint xl_ct, jobject xl_1, jobject xl_2, jobject xl_3, jobject xl_4, jobject xl_5, jobject xl_6, jobject xl_7, jobject xl_8, jobject xl_9 ) {
  const auto pt_qo = ( QObject * ) xl_qo;
  const auto pu_mn = jf_s ( xtl_jnv, xl_mn );
  const auto pu_ct = (int) xl_ct;
  QMetaObject::invokeMethod ( pt_qo, pu_mn .toStdString () .c_str (), (Qt::ConnectionType) pu_ct, Q_ARG ( jobject, xl_1 ), Q_ARG ( jobject, xl_2 ), Q_ARG ( jobject, xl_3 ), Q_ARG ( jobject, xl_4 ), Q_ARG ( jobject, xl_5 ), Q_ARG ( jobject, xl_6 ), Q_ARG ( jobject, xl_7 ), Q_ARG ( jobject, xl_8 ), Q_ARG ( jobject, xl_9 ) );
}

JNIEXPORT void JNICALL Java_DgQt_dp_1i10 ( JNIEnv * xtl_jnv, jclass, jlong xl_qo, jstring xl_mn, jint xl_ct, jobject xl_1, jobject xl_2, jobject xl_3, jobject xl_4, jobject xl_5, jobject xl_6, jobject xl_7, jobject xl_8, jobject xl_9, jobject xl_10 ) {
  const auto pt_qo = ( QObject * ) xl_qo;
  const auto pu_mn = jf_s ( xtl_jnv, xl_mn );
  const auto pu_ct = (int) xl_ct;
  QMetaObject::invokeMethod ( pt_qo, pu_mn .toStdString () .c_str (), (Qt::ConnectionType) pu_ct, Q_ARG ( jobject, xl_1 ), Q_ARG ( jobject, xl_2 ), Q_ARG ( jobject, xl_3 ), Q_ARG ( jobject, xl_4 ), Q_ARG ( jobject, xl_5 ), Q_ARG ( jobject, xl_6 ), Q_ARG ( jobject, xl_7 ), Q_ARG ( jobject, xl_8 ), Q_ARG ( jobject, xl_9 ), Q_ARG ( jobject, xl_10 ) );
}
