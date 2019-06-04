#include "__DgAkkaTellQo.h"

#include <QCoreApplication>

JNIEXPORT void JNICALL Java__1_1DgAkkaTellQo_dp_1it ( JNIEnv *, jclass, jlong xl_qo ) {
  QMetaObject ::invokeMethod ( ( QObject * ) xl_qo, "cn_it", Qt ::ConnectionType ::QueuedConnection );
}
