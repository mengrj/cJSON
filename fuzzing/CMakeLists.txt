option(ENABLE_FUZZING "Create executables and targets for fuzzing cJSON with afl." Off)
if (ENABLE_FUZZING)
    # Find AFL_FUZZ program, use the variable if specified
    if (NOT AFL_FUZZ)
        find_program(AFL_FUZZ afl-fuzz)
    endif()
    if (NOT AFL_FUZZ)
        message(FATAL_ERROR "Couldn't find afl-fuzz. Please set AFL_FUZZ path using -DAFL_FUZZ.")
    endif()

    add_executable(afl-main afl.c)
    target_link_libraries(afl-main "${CJSON_LIB}")

    if (NOT ENABLE_SANITIZERS)
        message(FATAL_ERROR "Enable sanitizers with -DENABLE_SANITIZERS=On to do fuzzing.")
    endif()

    option(ENABLE_FUZZING_PRINT "Fuzz printing functions together with parser." On)
    set(fuzz_print_parameter "no")
    if (ENABLE_FUZZING_PRINT)
        set(fuzz_print_parameter "yes")
    endif()

    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wno-error")

    # add_custom_target(afl
    #     COMMAND "${AFL_FUZZ}" -i "${CMAKE_CURRENT_SOURCE_DIR}/inputs" -o "${CMAKE_CURRENT_BINARY_DIR}/findings" -x "${CMAKE_CURRENT_SOURCE_DIR}/json.dict" -- "${CMAKE_CURRENT_BINARY_DIR}/afl-main" "@@" "${fuzz_print_parameter}"
    #     DEPENDS afl-main)


endif()

if(ENABLE_CJSON_TEST)
    ADD_EXECUTABLE(fuzz_main fuzz_main.c cjson_read_fuzzer.c)
    TARGET_LINK_LIBRARIES(fuzz_main cjson)
endif()

