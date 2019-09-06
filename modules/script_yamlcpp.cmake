# Check for yaml-cpp libray.

if(NOT DISABLE_YAMLCPP)
	FIND_PACKAGE(PkgConfig REQUIRED)
	find_package(yaml_cpp_catkin QUIET)
	if(${yaml_cpp_catkin_FOUND})
		message("Found yaml_cpp_catkin, using instead of system library.")
		set(YamlCpp_LIBRARIES ${yaml_cpp_catkin_LIBRARIES})
		set(YamlCpp_INCLUDE_DIRS ${yaml_cpp_catkin_INCLUDE_DIRS})
	else()
		message("No yaml_cpp_catkin, using yaml-cpp system library instead.")
		pkg_check_modules(YamlCpp REQUIRED yaml-cpp>=0.5)		
	endif()
endif()
