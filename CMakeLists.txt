cmake_minimum_required(VERSION 3.20)
project(SE_Exam_Ivans_Minajevs_PACMAN)

#include(FetchContent)
#
## Fetch LUA
## ++++++++++
#FetchContent_Declare(
#    lua
#    URL https://github.com/marovira/lua/archive/refs/tags/5.4.4.tar.gz
#)
#FetchContent_MakeAvailable(lua)
#
add_executable(${PROJECT_NAME} WIN32 AbstractGame.cpp AbstractGame.h Game.cpp Game.h GameDefines.h GameEngine.cpp GameEngine.h GameWinMain.cpp GameWinMain.h)


# Set C++ standard
set_target_properties(${PROJECT_NAME} PROPERTIES CXX_STANDARD 20 CXX_STANDARD_REQUIRED YES)

# Define Unicode preprocessor definitions
target_compile_definitions(${PROJECT_NAME} PRIVATE UNICODE _UNICODE)

# Include Win32 API headers
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_SOURCE_DIR})


include(FetchContent)

# Fetch LUA
FetchContent_Declare(
    lua
    URL https://github.com/marovira/lua/archive/refs/tags/5.4.4.tar.gz
)
FetchContent_MakeAvailable(lua)

# Fetch SOL2
FetchContent_Declare(
    sol2
    URL https://github.com/ThePhD/sol2/archive/refs/tags/v3.3.0.tar.gz
)
FetchContent_MakeAvailable(sol2)


# Force Lua Script Copy
add_custom_target(CopyScripts ALL
    COMMENT "Copying Lua scripts to output directory"
)


#add_custom_command(TARGET CopyScripts POST_BUILD
#    COMMAND ${CMAKE_COMMAND} -E copy_if_different
#    ${CMAKE_CURRENT_SOURCE_DIR}/script.lua
#    $<TARGET_FILE_DIR:${PROJECT_NAME}>/script.lua)
#
#
#add_dependencies(CopyScripts ${PROJECT_NAME})