add_subdirectory(input)

# Need to forward these variables to parent scope.
set(MAPNIK_PLUGINS ${MAPNIK_PLUGINS} PARENT_SCOPE)
set(MAPNIK_BINARY_DIRECTORIES ${MAPNIK_BINARY_DIRECTORIES} PARENT_SCOPE)
