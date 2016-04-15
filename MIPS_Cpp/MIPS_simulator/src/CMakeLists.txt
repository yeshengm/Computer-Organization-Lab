foreach(_var ${components})
    add_library(lib${_var} ${_var}.cpp ${_var}.hpp)
endforeach()
