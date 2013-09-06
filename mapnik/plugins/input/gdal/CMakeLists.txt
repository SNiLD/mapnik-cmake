set(mapnik_plugin_gdal_sources
    gdal_datasource.cpp
    gdal_featureset.cpp
    ../../../src/debug.cpp
    ../../../src/well_known_srs.cpp)

# Needed by GDAL
find_package(GeoTIFF REQUIRED)
find_package(GDAL REQUIRED)
include_directories(${GDAL_INCLUDE_DIR} ${GEOTIFF_INCLUDE_DIR})
list(APPEND mapnik_plugin_gdal_libraries ${GDAL_LIBRARY} ${GEOTIFF_LIBRARIES})
get_filename_component(geotiff_binary_directories ${GEOTIFF_INCLUDE_DIR}/../bin ABSOLUTE)
get_filename_component(gdal_binary_directories ${GDAL_INCLUDE_DIR}/../bin ABSOLUTE)
list(APPEND mapnik_plugin_gdal_binary_directories ${geotiff_binary_directories} ${gdal_binary_directories})

# boost
set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_STATIC_RUNTIME OFF)
find_package(Boost REQUIRED COMPONENTS system)
include_directories(${Boost_INCLUDE_DIRS})
add_definitions(-DBoost_LIB_DIAGNOSTIC_DEFINITIONS -DBOOST_ALL_DYN_LINK -DBOOST_ALL_NO_LIB)
list(APPEND mapnik_plugin_gdal_libraries ${Boost_LIBRARIES})
get_filename_component(boost_binary_directories ${Boost_LIBRARY_DIRS}/../bin ABSOLUTE)
list(APPEND mapnik_plugin_gdal_binary_directories ${boost_binary_directories})

# ICU
find_package(ICU REQUIRED)
include_directories(${ICU_INCLUDE_DIRS})
list(APPEND mapnik_plugin_gdal_libraries ${ICU_LIBRARIES})
get_filename_component(icu_binary_directories ${ICU_INCLUDE_DIRS}/../bin ABSOLUTE)
list(APPEND mapnik_plugin_gdal_binary_directories ${icu_binary_directories})

add_library(gdal MODULE ${mapnik_plugin_gdal_sources})

set_target_properties(gdal PROPERTIES SUFFIX ".input")

target_link_libraries(gdal ${mapnik_plugin_gdal_libraries} mapnik)

install(TARGETS gdal LIBRARY DESTINATION "bin/${CMAKE_BUILD_TYPE}/mapnik/input")

set(MAPNIK_PLUGINS ${MAPNIK_PLUGINS} ${CMAKE_INSTALL_PREFIX}/bin/${CMAKE_BUILD_TYPE}/mapnik/input/gdal.input PARENT_SCOPE)
set(MAPNIK_BINARY_DIRECTORIES ${MAPNIK_BINARY_DIRECTORIES} ${mapnik_plugin_gdal_binary_directories} ${CMAKE_CURRENT_BINARY_DIR} PARENT_SCOPE)