set(mapnik_plugin_shape_sources
    dbfile.cpp
    shape_datasource.cpp
    shape_featureset.cpp
    shape_index_featureset.cpp
    shape_io.cpp
    shape_utils.cpp)

# boost
set(Boost_USE_STATIC_LIBS OFF)
set(Boost_USE_STATIC_RUNTIME OFF)
find_package(Boost REQUIRED COMPONENTS system)
include_directories(${Boost_INCLUDE_DIRS})
add_definitions(-DBoost_LIB_DIAGNOSTIC_DEFINITIONS -DBOOST_ALL_DYN_LINK -DBOOST_ALL_NO_LIB)
list(APPEND mapnik_plugin_shape_libraries ${Boost_LIBRARIES})
get_filename_component(boost_binary_directories ${Boost_LIBRARY_DIRS}/../bin ABSOLUTE)
list(APPEND mapnik_plugin_shape_binary_directories ${boost_binary_directories})

# ICU
find_package(ICU REQUIRED)
include_directories(${ICU_INCLUDE_DIRS})
list(APPEND mapnik_plugin_shape_libraries ${ICU_LIBRARIES})
get_filename_component(icu_binary_directories ${ICU_INCLUDE_DIRS}/../bin ABSOLUTE)
list(APPEND mapnik_plugin_shape_binary_directories ${icu_binary_directories})

if (SHAPE_MEMORY_MAPPED_FILE)
    add_definitions(-DSHAPE_MEMORY_MAPPED_FILE)
endif (SHAPE_MEMORY_MAPPED_FILE)

add_library(shape MODULE ${mapnik_plugin_shape_sources})

set_target_properties(shape PROPERTIES SUFFIX ".input")

target_link_libraries(shape ${mapnik_plugin_shape_libraries} mapnik)

install(TARGETS shape LIBRARY DESTINATION "bin/${CMAKE_BUILD_TYPE}/mapnik/input")

set(MAPNIK_PLUGINS ${MAPNIK_PLUGINS} ${CMAKE_INSTALL_PREFIX}/bin/${CMAKE_BUILD_TYPE}/mapnik/input/shape.input PARENT_SCOPE)
set(MAPNIK_BINARY_DIRECTORIES ${MAPNIK_BINARY_DIRECTORIES} ${mapnik_plugin_shape_binary_directories} ${CMAKE_CURRENT_BINARY_DIR} PARENT_SCOPE)
