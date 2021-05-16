#ifndef GMC_INCLUDED_200204_1359
#define GMC_INCLUDED_200204_1359

//
// class lazy
//   from https://github.com/IntelRealSense/librealsense/blob/master/src/types.h
//

#include <functional>
#include <memory>
#include <mutex>

namespace Global {
  template < class T > class CgLazy {
  public :
    CgLazy () : __cavf_init ( [] () { T fv_it {}; return fv_it; } ) {}
    CgLazy ( std::function <T()> xvf_initializer ) : __cavf_init ( std::move (xvf_initializer) ) {}
    T * operator -> () const { return __cam_operate (); }
    T & operator * () { return * __cam_operate (); }
    const T & operator * () const { return * __cam_operate (); }
    CgLazy ( CgLazy && xrrv_other ) noexcept { // rrv = (r) value (r)eference (v)ariable
      std::lock_guard <std::mutex> lock (xrrv_other.__cav_mtx);
      if ( ! xrrv_other.__cav_was_init ) {
        __cavf_init = move (xrrv_other.__cavf_init);
        __cav_was_init = false;
      } else {
        __cavf_init = move (xrrv_other.__cavf_init);
        __cav_was_init = true;
        __cav_ptr = move (xrrv_other.__cav_ptr);
      }
    }
    CgLazy & operator = ( std::function <T()> xvf_it ) noexcept { return * this = CgLazy <T> ( std::move (xvf_it) ); }
    CgLazy & operator = ( CgLazy && xrrv_other ) noexcept {
      std::lock_guard <std::mutex> lock1 (__cav_mtx);
      std::lock_guard <std::mutex> lock2 (xrrv_other.__cav_mtx);
      if (!xrrv_other.__cav_was_init) {
        __cavf_init = move (xrrv_other.__cavf_init);
        __cav_was_init = false;
      } else {
        __cavf_init = move (xrrv_other.__cavf_init);
        __cav_was_init = true;
        __cav_ptr = move (xrrv_other.__cav_ptr);
      }
      return * this;
    }      
  private :
    T * __cam_operate () const {
      std::lock_guard <std::mutex> lock(__cav_mtx);
      if (!__cav_was_init) {
        __cav_ptr = std::unique_ptr <T> ( new T ( __cavf_init () ) );
        __cav_was_init = true;
      }
      return __cav_ptr .get ();
    }
    mutable std::mutex __cav_mtx;
    mutable bool __cav_was_init = false;
    std::function <T()> __cavf_init;
    mutable std::unique_ptr <T> __cav_ptr;
  };
}

#endif
