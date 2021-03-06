Building instructions
============

Building instructions are for Windows but you might be able to deduce where you should extract the dependencies in linux as well (or where they'll go if you use package managers).

Dependencies
------------

In this example we extract dependencies to `C:\libraries` but you can choose any location as long as you define the parameters correctly.

ICU:
 * Download: http://site.icu-project.org/download
 * Extract: `C:\libraries`
  
ZLIB:
 * Download: http://www.zlib.net/
 * Extract: `C:\libraries\zlib`

BOOST:
 * Download: http://sourceforge.net/projects/boost/files/boost-binaries/
 * Extract: `C:\libraries\boost_1_54_0`

Freetype:
 * Download: http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/
   * NOTE: Remember to also download the -dev package. 
 * Extract: `C:\libraries\freetype`

JPEG:
 * Download: http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/
   * NOTE: Remember to also download the -dev package.
   * NOTE2: Currently 6b contains proper library but 8d-1 does not.   
 * Extract: `C:\libraries`

PNG:
 * Download: http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/
   * NOTE: Remember to also download the -dev package. 
 * Extract: `C:\libraries`

TIFF:
 * Download: http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/
   * NOTE: Remember to also download the -dev package.
   * NOTE2: Currently 3.8 contains proper library but 3.9 series does not.    
 * Extract: `C:\libraries`
 
GDAL & Proj.4:
 * Download: http://www.gisinternals.com/sdk/
 * Extract: `C:\libraries\gdal`

Optional dependencies
---------------------

libxml2:
 * Download: http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/
    * NOTE: Remember to also download the -dev package.
 * Extract: `C:\libraries`
   
Cairo & fontconfig:
 * Download: http://ftp.gnome.org/pub/gnome/binaries/win32/dependencies/
   * NOTE: Remember to also download the -dev package.
 * Extract: `C:\libraries`    

Creating CMake project
----------------------

1. Extract mapnik sources to location of your preference.
 * In this example we extract to: `C:\mapnik` so you end up with `C:\mapnik\mapnik-v2.2.0`

2. Extract the CMake build files to the same location. So you should have:

    C:\mapnik\mapnik-v2.2.0\CMakeLists.txt
    C:\mapnik\mapnik-v2.2.0\src\CMakeLists.txt
    C:\mapnik\mapnik-v2.2.0\cmake\Modules
    C:\mapnik\mapnik-v2.2.0\plugins\input\CMakeLists.txt
    C:\mapnik\mapnik-v2.2.0\plugins\input\[plugin]\CMakeLists.txt

3. Open debug visual studio shell.
 * I start mine with following shortcut: `C:\Windows\System32\cmd.exe /K""C:\Program Files\Microsoft SDKs\Windows\v7.1\Bin\SetEnv.Cmd" /x86 /Debug /win7 && "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" x86"`

4. Define environment variables for dependency libraries:
    set FREETYPE_DIR=C:\libraries\freetype
    set GDAL_ROOT=C:\libraries\gdal
    set LIB_DIR=C:\libraries

5. Go to directory above the mapnik sources: `cd C:\mapnik`

6. Create a build directory: `mkdir mapnik-debug`

7. Go to the build directory: `cd mapnik-debug`

8. Create cmake project: `cmake -G"NMake Makefiles" -DCMAKE_BUILD_TYPE:STRING=Debug -DCMAKE_PREFIX_PATH:PATH=C:\libraries -DICU_ROOT=C:\libraries\icu -DZLIB_ROOT=C:\libraries\zlib -DBOOST_ROOT=C:\libraries\boost_1_54_0 -DBOOST_LIBRARYDIR=C:\libraries\boost_1_54_0\lib32-msvc-10.0 ..\mapnik-v2.2.0`
 * If you have specific name for JPEG library (lets say libjpeg-8) you can add this to above command: `-DJPEG_NAMES=libjpeg-8`
 * If you have specific name for PNG library (lets say libpng15-15) you can add this to above command: `-DPNG_NAMES=libpng15-15`
 * If you have specific name for TIFF library (lets say libtiff-5) your can add this to above command: `-DTIFF_NAMES=libtiff-5`

9. Make the project: `nmake install`
 * NOTE: If your build fails here to fixup bundle dependencies, you have downloaded incorrect versions of some of the dependant library (cairo depends on a specific version of libpng for example).

You should now have `lib/MSVC/Debug/mapnik.lib` and `bin/Debug/mapnik.dll` in `C:\mapnik\deployment` directory.

To build release version start from step 2. and replace every Debug word with Release.
 * Visual Studio release shell
 * mapnik-release build directory
 * CMAKE_BUILD_TYPE=Release
 