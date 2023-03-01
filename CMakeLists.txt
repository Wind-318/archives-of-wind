cmake_minimum_required(VERSION 3.24.3)
project(archives_of_wind CXX)

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
set(CMAKE_CXX_STANDARD 20)
message(STATUS "Use C++20")
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

file(MAKE_DIRECTORY archives log)

if(WIN32)
    if(NOT DEFINED CMAKE_TOOLCHAIN_FILE)
        message(FATAL_ERROR "Please specify the path to the vcpkg toolchain file with the CMAKE_TOOLCHAIN_FILE variable.")
    endif()
    include(${CMAKE_TOOLCHAIN_FILE})
    find_package(benchmark CONFIG REQUIRED)
    find_package(Drogon CONFIG REQUIRED)
    find_package(GTest CONFIG REQUIRED)
    find_package(Protobuf CONFIG REQUIRED)
else()
    find_package(benchmark REQUIRED)
    find_package(Drogon REQUIRED)
    find_package(GTest REQUIRED)
    find_package(Protobuf REQUIRED)
endif()

add_executable(${PROJECT_NAME} main.cc)

target_link_libraries(${PROJECT_NAME} PRIVATE benchmark::benchmark benchmark::benchmark_main)
target_link_libraries(${PROJECT_NAME} PRIVATE Drogon::Drogon)
target_link_libraries(${PROJECT_NAME} PRIVATE GTest::gmock GTest::gtest GTest::gmock_main GTest::gtest_main)
target_link_libraries(${PROJECT_NAME} PRIVATE protobuf::libprotoc protobuf::libprotobuf protobuf::libprotobuf-lite)

aux_source_directory(controllers CTL_SRC)
aux_source_directory(filters FILTER_SRC)
aux_source_directory(plugins PLUGIN_SRC)
aux_source_directory(models MODEL_SRC)
aux_source_directory(src SRC_DIR)
aux_source_directory(protodata PROTODATA_SRC)

drogon_create_views(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/views ${CMAKE_CURRENT_BINARY_DIR})

target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/models)

target_sources(${PROJECT_NAME} PRIVATE ${SRC_DIR} ${CTL_SRC} ${FILTER_SRC} ${PLUGIN_SRC} ${MODEL_SRC} ${PROTODATA_SRC})

add_subdirectory(test)