set(mapnik_plugin_osm_sources
    basiccurl.cpp
    dataset_deliverer.cpp
    osm_datasource.cpp
    osm_featureset.cpp
    osm.cpp
    osmparser.cpp)

find_package(LibXml2 REQUIRED)
find_package(CURL REQUIRED)
set_package_properties(CURL PROPERTIES
    DESCRIPTION "Tool for transferring data with URL syntax"
    URL "http://curl.haxx.se/"
    TYPE REQUIRED
    PURPOSE "Enables fetching OSM data.")

include_directories(${LIBXML2_INCLUDE_DIR} ${CURL_INCLUDE_DIRS})
add_definitions(${LIBXML2_DEFINITIONS} -DHAVE_LIBXML2)
list(APPEND mapnik_plugin_osm_libraries ${LIBXML2_LIBRARIES} ${CURL_LIBRARIES})
get_filename_component(xml2_binary_directories ${LIBXML2_LIBRARIES}/../../bin ABSOLUTE)
get_filename_component(curl_binary_directories ${CURL_LIBRARIES}/../../bin ABSOLUTE)
list(APPEND mapnik_plugin_osm_binary_directories ${xml2_binary_directories} ${curl_binary_directories})

# boost
set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_STATIC_RUNTIME OFF)
find_package(Boost REQUIRED COMPONENTS system)
include_directories(${Boost_INCLUDE_DIRS})
add_definitions(-DBoost_LIB_DIAGNOSTIC_DEFINITIONS -DBOOST_ALL_DYN_LINK -DBOOST_ALL_NO_LIB)
list(APPEND mapnik_plugin_osm_libraries ${Boost_LIBRARIES})
get_filename_component(boost_binary_directories ${Boost_LIBRARY_DIRS}/../bin ABSOLUTE)
list(APPEND mapnik_plugin_osm_binary_directories ${boost_binary_directories})

# ICU
find_package(ICU REQUIRED)
include_directories(${ICU_INCLUDE_DIRS})
list(APPEND mapnik_plugin_osm_libraries ${ICU_LIBRARIES})
get_filename_component(icu_binary_directories ${ICU_INCLUDE_DIRS}/../bin ABSOLUTE)
list(APPEND mapnik_plugin_osm_binary_directories ${icu_binary_directories})

add_library(osm MODULE ${mapnik_plugin_osm_sources})

set_target_properties(osm PROPERTIES SUFFIX ".input")

target_link_libraries(osm ${mapnik_plugin_osm_libraries} mapnik)

install(TARGETS osm LIBRARY DESTINATION "bin/${CMAKE_BUILD_TYPE}/mapnik/input")

set(MAPNIK_PLUGINS ${MAPNIK_PLUGINS} ${CMAKE_INSTALL_PREFIX}/bin/${CMAKE_BUILD_TYPE}/mapnik/input/osm.input PARENT_SCOPE)
set(MAPNIK_BINARY_DIRECTORIES ${MAPNIK_BINARY_DIRECTORIES} ${mapnik_plugin_osm_binary_directories} ${CMAKE_CURRENT_BINARY_DIR} PARENT_SCOPE)
