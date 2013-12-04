if (PLUGIN_CSV)
    message(STATUS "Adding CSV plugin...")
    add_subdirectory(csv)
endif (PLUGIN_CSV)

if (PLUGIN_GDAL)
    message(STATUS "Adding GDAL plugin...")
    add_subdirectory(gdal)
endif (PLUGIN_GDAL)

if (PLUGIN_OGR)
    message(STATUS "Adding OGR plugin...")
    add_subdirectory(ogr)
endif (PLUGIN_OGR)

if (PLUGIN_OSM)
    message(STATUS "Adding OpenStreetMap plugin...")
    add_subdirectory(osm)
endif (PLUGIN_OSM)

if (PLUGIN_RASTER)
    message(STATUS "Adding raster plugin...")
    add_subdirectory(raster)
endif (PLUGIN_RASTER)

if (PLUGIN_RASTERLITE)
    message(STATUS "Adding rasterlite plugin...")
    add_subdirectory(rasterlite)
endif (PLUGIN_RASTERLITE)

if (PLUGIN_SHAPE)
    message(STATUS "Adding shape plugin...")
    add_subdirectory(shape)
endif (PLUGIN_SHAPE)

if (PLUGIN_SQLITE)
    message(STATUS "Adding sqlite plugin...")
    add_subdirectory(sqlite)
endif (PLUGIN_SQLITE)

# Need to forward these variables to parent scope.
set(MAPNIK_PLUGINS ${MAPNIK_PLUGINS} PARENT_SCOPE)
set(MAPNIK_BINARY_DIRECTORIES ${MAPNIK_BINARY_DIRECTORIES} PARENT_SCOPE)
