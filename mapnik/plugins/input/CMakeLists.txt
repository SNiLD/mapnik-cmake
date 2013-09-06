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

if (PLUGIN_RASTER)
    message(STATUS "Adding raster plugin...")
    add_subdirectory(raster)
endif (PLUGIN_RASTER)

if (PLUGIN_SHAPE)
    message(STATUS "Adding shape plugin...")
    add_subdirectory(shape)
endif (PLUGIN_SHAPE)

# Need to forward these variables to parent scope.
set(MAPNIK_PLUGINS ${MAPNIK_PLUGINS} PARENT_SCOPE)
set(MAPNIK_BINARY_DIRECTORIES ${MAPNIK_BINARY_DIRECTORIES} PARENT_SCOPE)
