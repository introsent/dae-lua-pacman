cmake_minimum_required(VERSION 3.20)
project(SE_Exam_Ivans_Minajevs_PACMAN)


include(FetchContent)
# Fetch Lua
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

# Define the executable
add_executable(${PROJECT_NAME} WIN32 
    AbstractGame.cpp 
    AbstractGame.h 
    Game.cpp 
    Game.h 
    GameDefines.h 
    GameEngine.cpp 
    GameEngine.h 
    GameWinMain.cpp 
    GameWinMain.h
)

# Set C++ standard
set_target_properties(${PROJECT_NAME} PROPERTIES CXX_STANDARD 17 CXX_STANDARD_REQUIRED YES)

# Define Unicode preprocessor definitions
target_compile_definitions(${PROJECT_NAME} PRIVATE UNICODE _UNICODE)

# Include Win32 API headers
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_SOURCE_DIR})

# Link libraries for Sol2 and Lua
target_link_libraries(${PROJECT_NAME} PRIVATE sol2 lua::lua)  

# Force Lua Script Copy
add_custom_target(CopyScripts ALL
    COMMENT "Copying Lua scripts to output directory"
)

# Force Resources Copy
add_custom_target(CopyResources ALL
    COMMENT "Copying all assets to output directory"
)

# Copy Lua Scripts Command
add_custom_command(TARGET CopyScripts POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory_if_different
            ${CMAKE_CURRENT_SOURCE_DIR}/scripts/
            $<TARGET_FILE_DIR:${PROJECT_NAME}>/scripts)

# Copy Resources Command
add_custom_command(TARGET CopyResources POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory_if_different
            ${CMAKE_CURRENT_SOURCE_DIR}/resources/
            $<TARGET_FILE_DIR:${PROJECT_NAME}>/resources)

# Make the main project depend on the custom copy targets
add_dependencies(${PROJECT_NAME} CopyScripts)
add_dependencies(${PROJECT_NAME} CopyResources)
