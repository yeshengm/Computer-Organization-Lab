project(project2)

list(APPEND CMAKE_CXX_FLAGS "-std=c++11 -g")
include_directories(src)
# set(EXECUTABLE_OUTPUT_PATH ${CMAKE_SOURCE_DIR}/obj)
set(components "component" "memory" "reg" "alu" "alucontrol" "pc" "ctr" "other" "cpu")
ADD_SUBDIRECTORY(test)
ADD_SUBDIRECTORY(src)
