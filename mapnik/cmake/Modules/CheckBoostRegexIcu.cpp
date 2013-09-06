#include <boost/regex/icu.hpp>
#include <unicode/unistr.h>

int main()
{
    UnicodeString ustr;
    try {
        boost::u32regex pattern = boost::make_u32regex(ustr);
    }
    // an exception is fine, still indicates support is
    // likely compiled into regex
    catch (...) {
        return 0;
    }
    return 0;
}
