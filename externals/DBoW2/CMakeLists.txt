# MOLA:
# Instead of including the original DBoW2 cmake file, which "polutes" the
# global space of cmake variables, let's just create here the targets that
# we need, in the parent directory of the actual DBoW2 directory:
# =================================================================
# DBoW2: bag-of-words library for C++ with generic descriptors
# Copyright (c) 2015 Dorian Galvez-Lopez. http://doriangalvez.com
# All rights reserved.
# =================================================================
# License: 3-BSD
# =================================================================
project(dbow2)

set(HDRS
  DBoW2/include/DBoW2/BowVector.h
  DBoW2/include/DBoW2/FBrief.h
  DBoW2/include/DBoW2/QueryResults.h
  DBoW2/include/DBoW2/TemplatedDatabase.h
  DBoW2/include/DBoW2/FORB.h
  DBoW2/include/DBoW2/DBoW2.h
  DBoW2/include/DBoW2/FClass.h
  DBoW2/include/DBoW2/FeatureVector.h
  DBoW2/include/DBoW2/ScoringObject.h
  DBoW2/include/DBoW2/TemplatedVocabulary.h
)
set(SRCS
  DBoW2/src/BowVector.cpp
  DBoW2/src/FBrief.cpp
  DBoW2/src/FORB.cpp
  DBoW2/src/FeatureVector.cpp
  DBoW2/src/QueryResults.cpp
  DBoW2/src/ScoringObject.cpp
)

message("project binary dir ${PROJECT_BINARY_DIR}")
message("cmake binary dir ${CMAKE_BINARY_DIR}")
message("cmake current binary dir ${CMAKE_CURRENT_BINARY_DIR}")

set(DBOW_DEPENDENCY_DIR ${CMAKE_CURRENT_BINARY_DIR}/dependencies)
set(DBOW_DEPENDENCY_INSTALL_DIR ${DBOW_DEPENDENCY_DIR}/install)

find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})

add_library(${PROJECT_NAME} SHARED ${SRCS})
target_include_directories(${PROJECT_NAME} PUBLIC DBoW2/include)
target_link_libraries(${PROJECT_NAME} ${OpenCV_LIBS})

configure_file(DBoW2/src/DBoW2.cmake.in
  "${PROJECT_BINARY_DIR}/DBoW2Config.cmake" @ONLY)
install(TARGETS ${PROJECT_NAME} DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)

install(DIRECTORY DBoW2/include/DBoW2 DESTINATION ${CMAKE_INSTALL_PREFIX}/include)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/DBoW2Config.cmake"
  DESTINATION ${CMAKE_INSTALL_PREFIX}/include/${PROJECT_NAME})
install(FILES "${PROJECT_BINARY_DIR}/DBoW2Config.cmake"
  DESTINATION ${CMAKE_INSTALL_PREFIX}/lib/cmake/DBoW2/)
install(DIRECTORY ${DBOW_DEPENDENCY_INSTALL_DIR}/ DESTINATION ${CMAKE_INSTALL_PREFIX} OPTIONAL)
