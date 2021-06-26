#include <DgOriginalSorcePath.hpp>

namespace Global { namespace DgOriginalSorcePath {
  std::string __daf_path ( std::string xv_fn ) {
    const size_t fu_last_backslash = xv_fn .rfind ('\\');
    if ( std::string::npos != fu_last_backslash ) { return xv_fn .substr ( 0, fu_last_backslash ); }
    const size_t fu_last_slash = xv_fn .rfind ('/');
    if ( std::string::npos != fu_last_slash ) { return xv_fn .substr ( 0, fu_last_slash ); }
    return xv_fn;
  }
  const std::string du_sym = "@$";
  const std::string du_it = __daf_path (__FILE__);
  const std::string df_to_s ( std::string xv_fn ) {
    const auto fu_pn = du_it;
    const auto FC_SZ_PN = fu_pn .size ();
    const size_t fu_last = xv_fn .find (fu_pn);
    if ( std::string::npos != fu_last && 0 == fu_last ) { return du_sym + xv_fn .substr ( FC_SZ_PN, xv_fn .size () - FC_SZ_PN ); }
    return xv_fn;
  }
} }
