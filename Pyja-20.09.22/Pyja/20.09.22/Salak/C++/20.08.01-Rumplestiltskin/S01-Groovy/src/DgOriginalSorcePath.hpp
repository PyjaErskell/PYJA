#ifndef GMC_INCLUDED_200117_1810
#define GMC_INCLUDED_200117_1810

#include <string>

namespace Global { namespace DgOriginalSorcePath {
  extern const std::string du_sym; // (sym)bol of original source path
  extern const std::string du_it; // orignal source path
  extern const std::string df_to_s (std::string); // (to) (s)ymbol
} }

// (g)lobal (m)acro e(x)pression file
#define GMX_FILE Global::DgOriginalSorcePath::df_to_s (__FILE__)

#endif
