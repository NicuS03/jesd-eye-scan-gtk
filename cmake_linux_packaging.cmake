# CMake packaging configuration for jesd-eye-scan-gtk
set(CPACK_SET_DESTDIR ON)
set(CPACK_GENERATOR "")  # Start with empty generator list

# Check for DEB package creation capability
FIND_PROGRAM(DEBBUILD_CMD dpkg)
if (DEBBUILD_CMD)
    set(CPACK_GENERATOR DEB)
    
    # Debian package dependencies
    set(CPACK_DEBIAN_PACKAGE_DEPENDS "libgtk-3-0, libncurses6, gnuplot")
    
    # Package metadata
    if(DEFINED MAINTAINER)
      set(CPACK_DEBIAN_PACKAGE_MAINTAINER "${MAINTAINER}")
    else()
      set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Unknown Maintainer")
    endif()
   
    set(CPACK_DEBIAN_PACKAGE_DESCRIPTION "Eye Scan Visualization Utility")
    set(CPACK_DEBIAN_PACKAGE_SECTION "utils")
    set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "all")
    
    # Custom post-install script to handle desktop file
    set(CPACK_DEBIAN_PACKAGE_CONTROL_EXTRA "${CMAKE_CURRENT_SOURCE_DIR}/postinst;")
    
    message(STATUS "Package dependencies (.deb): ${CPACK_DEBIAN_PACKAGE_DEPENDS}")
else()
    message(FATAL_ERROR "dpkg not found - cannot create .deb packages")
endif()

# General package settings
set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY 0)
set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})
set(CPACK_PACKAGE_VERSION ${PROJECT_VERSION_DEB})
set(CPACK_PACKAGE_NAME "jesd-eye-scan-gtk")
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}_${CPACK_PACKAGE_VERSION}_${CPACK_DEBIAN_PACKAGE_ARCHITECTURE}")

# Include CPack
include(CPack)
