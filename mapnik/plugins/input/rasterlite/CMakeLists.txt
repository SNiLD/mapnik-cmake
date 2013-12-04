set(mapnik_plugin_rasterlite_sources
    rasterlite_datasource.cpp
    rasterlite_featureset.cpp)

find_package(GeoTIFF REQUIRED)
set_package_properties(GeoTIFF PROPERTIES
    DESCRIPTION "TIFF based interchange format for georeferenced raster imagery"
    URL "http://trac.osgeo.org/geotiff/"
    TYPE REQUIRED
    PURPOSE "Enables support for handling GeoTIFF data.")

include_directories(${GEOTIFF_INCLUDE_DIR})
list(APPEND mapnik_plugin_rasterlite_libraries ${GEOTIFF_LIBRARIES})
get_filename_component(geotiff_binary_directories ${GEOTIFF_INCLUDE_DIR}/../bin ABSOLUTE)
list(APPEND mapnik_plugin_rasterlite_binary_directories ${geotiff_binary_directories})

find_package(Sqlite3 REQUIRED)
set_package_properties(Sqlite3 PROPERTIES
    DESCRIPTION "Software library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine."
    URL "http://www.sqlite.org/"
    TYPE REQUIRED
    PURPOSE "Enables queries from SQLite databases.")
    
include_directories(${SQLITE3_INCLUDE_DIR})
list(APPEND mapnik_plugin_rasterlite_libraries ${SQLITE3_LIBRARY})
get_filename_component(sqlite3_binary_directories ${SQLITE3_LIBRARY}/../../bin ABSOLUTE)
list(APPEND mapnik_plugin_rasterlite_binary_directories ${sqlite3_binary_directories})

find_package(SPATIALITE)
set_package_properties(SPATIALITE PROPERTIES
    DESCRIPTION "Library extending the basic SQLite core in order to get a full fledged Spatial DBMS, really simple and lightweight, but mostly OGC-SFS compliant."
    URL "http://www.gaia-gis.it/gaia-sins/"
    TYPE REQUIRED
    PURPOSE "Enables spatial queries from SQLite databases.")

include_directories(${SPATIALITE_INCLUDE_DIR})
list(APPEND mapnik_plugin_rasterlite_libraries ${SPATIALITE_LIBRARY})
get_filename_component(spatialite_binary_directories ${SPATIALITE_LIBRARY}/../../bin ABSOLUTE)
list(APPEND mapnik_plugin_rasterlite_binary_directories ${spatialite_binary_directories})

find_package(RASTERLITE REQUIRED)
set_package_properties(RASTERLITE PROPERTIES
    DESCRIPTION "Library that stores and retrieves huge raster coverages using a SpatiaLite DBMS. "
    URL "https://www.gaia-gis.it/fossil/librasterlite/"
    TYPE REQUIRED
    PURPOSE "Enables queries with rasterlite.")

include_directories(${RASTERLITE_INCLUDE_DIR})
list(APPEND mapnik_plugin_rasterlite_libraries ${RASTERLITE_LIBRARY})
get_filename_component(rasterlite_binary_directories ${RASTERLITE_LIBRARY}/../../bin ABSOLUTE)
list(APPEND mapnik_plugin_rasterlite_binary_directories ${rasterlite_binary_directories})

# boost
set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_STATIC_RUNTIME OFF)
find_package(Boost REQUIRED COMPONENTS system)
include_directories(${Boost_INCLUDE_DIRS})
add_definitions(-DBoost_LIB_DIAGNOSTIC_DEFINITIONS -DBOOST_ALL_DYN_LINK -DBOOST_ALL_NO_LIB)
list(APPEND mapnik_plugin_rasterlite_libraries ${Boost_LIBRARIES})
get_filename_component(boost_binary_directories ${Boost_LIBRARY_DIRS}/../bin ABSOLUTE)
list(APPEND mapnik_plugin_rasterlite_binary_directories ${boost_binary_directories})

# ICU
find_package(ICU REQUIRED)
include_directories(${ICU_INCLUDE_DIRS})
list(APPEND mapnik_plugin_rasterlite_libraries ${ICU_LIBRARIES})
get_filename_component(icu_binary_directories ${ICU_INCLUDE_DIRS}/../bin ABSOLUTE)
list(APPEND mapnik_plugin_rasterlite_binary_directories ${icu_binary_directories})

add_library(rasterlite MODULE ${mapnik_plugin_rasterlite_sources})

set_target_properties(rasterlite PROPERTIES SUFFIX ".input")

target_link_libraries(rasterlite ${mapnik_plugin_rasterlite_libraries} mapnik)

install(TARGETS rasterlite LIBRARY DESTINATION "bin/${CMAKE_BUILD_TYPE}/mapnik/input")

set(MAPNIK_PLUGINS ${MAPNIK_PLUGINS} ${CMAKE_INSTALL_PREFIX}/bin/${CMAKE_BUILD_TYPE}/mapnik/input/rasterlite.input PARENT_SCOPE)
set(MAPNIK_BINARY_DIRECTORIES ${MAPNIK_BINARY_DIRECTORIES} ${mapnik_plugin_rasterlite_binary_directories} ${CMAKE_CURRENT_BINARY_DIR} PARENT_SCOPE)
