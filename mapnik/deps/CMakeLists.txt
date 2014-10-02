# Install dependencies
install(DIRECTORY agg/include DESTINATION . FILES_MATCHING PATTERN "*.h*")

list(REMOVE_DUPLICATES MAPNIK_BINARY_DIRECTORIES)
install(CODE "
    unset(mapnik_plugins_absolute)
    foreach(mapnik_plugin \"${MAPNIK_PLUGINS}\")
        get_filename_component(mapnik_plugin_absolute \"\${mapnik_plugin}\" ABSOLUTE)
        list(APPEND mapnik_plugins_absolute \"\${mapnik_plugin_absolute}\")
    endforeach(mapnik_plugin)
    
    unset(mapnik_binary_directories_absolute)
    foreach(mapnik_binary_directory \"${MAPNIK_BINARY_DIRECTORIES}\")
        get_filename_component(mapnik_binary_directory_absolute \"\${mapnik_binary_directory}\" ABSOLUTE)
        list(APPEND mapnik_binary_directories_absolute \"\${mapnik_binary_directory_absolute}\")
    endforeach(mapnik_binary_directory)
    
    get_filename_component(mapnik_binary_absolute \"${CMAKE_INSTALL_PREFIX}/bin/${CMAKE_BUILD_TYPE}/mapnik${CMAKE_EXECUTABLE_SUFFIX}\" ABSOLUTE)
    include(BundleUtilities)
    fixup_bundle(
        \"\${mapnik_binary_absolute}\"
        \"\${mapnik_plugins_absolute}\"
        \"\${mapnik_binary_directories_absolute}\")
    if(WIN32)
        file(REMOVE \${mapnik_binary_absolute})
    endif(WIN32)
")
