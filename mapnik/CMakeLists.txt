cmake_minimum_required (VERSION 2.8)

project (mapnik)

include(CMakeDependentOption)
include(FeatureSummary)

set(CMAKE_INSTALL_PREFIX "${CMAKE_CURRENT_BINARY_DIR}/../deployment" CACHE INTERNAL "Default installation path")

option(USE_JPEG "Compile with JPEG support" TRUE)
option(USE_PNG "Compile with PNG support" TRUE)
option(USE_TIFF "Compile with TIFF support" TRUE)
option(USE_SVG "Compile with SVG support" TRUE)
option(USE_LIBXML2 "Use libxml2 as XML library" TRUE)
option(USE_CAIRO "Use cairo as rendering library" TRUE)
option(PLUGIN_CSV "Compile CSV plugin" TRUE)
option(PLUGIN_GDAL "Compile GDAL plugin" TRUE)
option(PLUGIN_OGR "Compile OGR plugin" TRUE)
option(PLUGIN_OSM "Compile OpenStreetMap plugin" TRUE)
option(PLUGIN_RASTER "Compile raster plugin" TRUE)
option(PLUGIN_SHAPE "Compile shape plugin" TRUE)
CMAKE_DEPENDENT_OPTION(SHAPE_MEMORY_MAPPED_FILE "Use memory mapped file" OFF "PLUGIN_SHAPE" OFF)
option(ENABLE_STATS "If set to TRUE then timing output will be printed to stderr of a variety of performance critical code paths. The default value is FALSE." FALSE)
option(ENABLE_LOG "This option controls which severity levels should be compiled into the Mapnik binary. The default value is FALSE. This default means that not all severity types will be compiled into Mapnik: only error and none levels will be available to toggle at runtime. The reason for this is to ensure that Mapnik runs fast by default, because verbose logging can slow down code execution. If set to TRUE then logging of all severity types will be enabled and available at runtime. NOTE: This option defaults to TRUE if in debug builds." FALSE)
set(DEFAULT_LOG_SEVERITY "error" CACHE STRING "The DEFAULT_LOG_SEVERITY option controls which severity level will be used by default at runtime - the value it will be initialized to at startup. It is not recommended to change this option at configuration time, unless you are a developer or doing customized packaging of Mapnik. Users can change the severity level easily at runtime. The default level is error. Other named severity levels are: debug, warn, none. An important caveat is that the ENABLE_LOG option controls which severity levels are compiled into Mapnik by default, so setting DEFAULT_LOG_SEVERITY to warn or debug will have no effect unless ENABLE_LOG is TRUE.")
option(RENDERING_STATS "This is an experimental option that may be removed in future releases. It defaults to FALSE, but can be set to TRUE to enable verbose logging of rendering behavior providing the timing of style and layer processing." FALSE)
option(THREAD_SAFE "Build mapnik in thread-safe mode" TRUE)

set(CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake/Modules)

include_directories(
    ${mapnik_SOURCE_DIR}
    ${mapnik_BINARY_DIR}
    ${mapnik_SOURCE_DIR}/deps
    ${mapnik_SOURCE_DIR}/deps/agg/include
    ${mapnik_SOURCE_DIR}/deps/clipper/include
    ${mapnik_SOURCE_DIR}/include
)

if (UNIX)
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++0x")
endif()

set(MAPNIK_PLUGINS "" CACHE INTERNAL "Full paths to mapnik plugins. Automatically filled.")
set(MAPNIK_BINARY_DIRECTORIES "" CACHE INTERNAL "Full paths to directories of dependencies. Automatically filled.")

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(ENABLE_LOG TRUE)
endif (CMAKE_BUILD_TYPE STREQUAL "Debug")

add_feature_info("JPEG support" USE_JPEG "Compile with JPEG support")
add_feature_info("PNG support" USE_PNG "Compile with PNG support")
add_feature_info("TIFF support" USE_TIFF "Compile with TIFF support")
add_feature_info("SVG support" USE_SVG "Compile with SVG support")
add_feature_info("libxml2 library" USE_LIBXML2 "Use libxml2 library")
add_feature_info("cairo library" USE_CAIRO "Use cairo renderer library")

add_feature_info("CSV plugin" PLUGIN_CSV "CSV plugin")
add_feature_info("GDAL plugin" PLUGIN_GDAL "GDAL plugin")
add_feature_info("OGR plugin" PLUGIN_OGR "OGR plugin")
add_feature_info("raster plugin" PLUGIN_RASTER "raster plugin")
add_feature_info("shape plugin" PLUGIN_SHAPE "shape plugin")

add_feature_info("Thread safe" THREAD_SAFE "Compile to use thread locks")
add_feature_info("Statistics" ENABLE_STATS "Compile with extensive statistics")
add_feature_info("Logging" ENABLE_LOG "Compile with logging support")
add_feature_info("Rendering statistics" RENDERING_STATS "Compile with rendering stats")

if (THREAD_SAFE)
    add_definitions(-DMAPNIK_THREADSAFE)
endif (THREAD_SAFE)

if (ENABLE_STATS)
    add_definitions(-DMAPNIK_STATS)
endif (ENABLE_STATS)

if (ENABLE_LOG)
    add_definitions(-DMAPNIK_LOG -DMAPNIK_DEFAULT_LOG_SEVERITY=${DEFAULT_LOG_SEVERITY})
endif (ENABLE_LOG)

if (RENDERING_STATS)
    add_definitions(-DRENDERING_STATS)
endif (RENDERING_STATS)

add_subdirectory(src)
add_subdirectory(plugins)
add_subdirectory(deps)

# Install includes
install(DIRECTORY include DESTINATION . FILES_MATCHING PATTERN "*.hpp")

feature_summary(WHAT ALL VAR enabledFeaturesText)

message(STATUS "${enabledFeaturesText}")
