# Find rasterlite
# ~~~~~~~~~~~~~~~
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.
#
# CMake module to search for rasterlite library
#
# If it's found it sets RASTERLITE_FOUND to TRUE
# and following variables are set:
#    RASTERLITE_INCLUDE_DIR
#    RASTERLITE_LIBRARY


# FIND_PATH and FIND_LIBRARY normally search standard locations
# before the specified paths. To search non-standard paths first,
# FIND_* is invoked first with specified paths and NO_DEFAULT_PATH
# and then again with no specified paths to search the default
# locations. When an earlier FIND_* succeeds, subsequent FIND_*s
# searching for the same item do nothing. 

FIND_PATH(RASTERLITE_INCLUDE_DIR rasterlite.h
  "$ENV{LIB_DIR}/include"
  #mingw
  c:/msys/local/include
  NO_DEFAULT_PATH
  )
FIND_PATH(RASTERLITE_INCLUDE_DIR rasterlite.h)

FIND_LIBRARY(RASTERLITE_LIBRARY NAMES rasterlite_i PATHS
  "$ENV{LIB_DIR}/lib"
  #mingw
  c:/msys/local/lib
  NO_DEFAULT_PATH
  )
FIND_LIBRARY(RASTERLITE_LIBRARY NAMES rasterlite)

IF (RASTERLITE_INCLUDE_DIR AND RASTERLITE_LIBRARY)
   SET(RASTERLITE_FOUND TRUE)
ENDIF (RASTERLITE_INCLUDE_DIR AND RASTERLITE_LIBRARY)


IF (RASTERLITE_FOUND)

   IF (NOT RASTERLITE_FIND_QUIETLY)
      MESSAGE(STATUS "Found rasterlite: ${RASTERLITE_LIBRARY}")
   ENDIF (NOT RASTERLITE_FIND_QUIETLY)

ELSE (RASTERLITE_FOUND)

   IF (RASTERLITE_FIND_REQUIRED)
      MESSAGE(FATAL_ERROR "Could not find rasterlite")
   ENDIF (RASTERLITE_FIND_REQUIRED)

ENDIF (RASTERLITE_FOUND)
