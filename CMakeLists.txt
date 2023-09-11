# 设置 CMake 最低支持版本
cmake_minimum_required(VERSION 3.17)
# 引用 Cortex-M3.cmake
include(cmake/Cortex-M3.cmake)
set(PRJ_NAME "Practice_MCU")
# 定义工程名称
project(${PRJ_NAME} LANGUAGES CXX C)
# 设置支持 ASM 
ENABLE_LANGUAGE(ASM)

# 添加 gd_libs 和 src
add_subdirectory(extern/Firmware)
add_subdirectory(src)
