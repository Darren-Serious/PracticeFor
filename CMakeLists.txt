# 设置 CMake 最低支持版本
cmake_minimum_required(VERSION 3.17)
set(CMAKE_TOOLCHAIN_FILE cmake/mcu-toolchain.cmake)

project(PRO_MCU)
enable_language(ASM)

set(CMAKE_MAKE_PROGRAM CXX)

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 11)

file(GLOB_RECURSE C_SOURCES CONFIGURE_DEPENDS
  extern/Firmware/CMSIS/Source/*.c
  extern/Firmware/standard_peripheral/Source/*.c
  src/PMU/*.cpp)

add_executable(${CMAKE_PROJECT_NAME}.elf ${C_SOURCES} extern/Firmware/CMSIS/Source/gcc_startup/startup_gd32f10x_md.S)

target_include_directories(${CMAKE_PROJECT_NAME}.elf PRIVATE
  extern/Firmware/CMSIS/Include
  extern/Firmware/standard_peripheral/Include)

target_compile_definitions(${CMAKE_PROJECT_NAME}.elf PRIVATE
  # USE_FULL_ASSERT
  USE_STDPERIPH_DRIVER
  GD32F10X_MD)

set(MCU_FLAGS -mcpu=cortex-m3 -mthumb)

target_compile_options(${CMAKE_PROJECT_NAME}.elf PRIVATE ${MCU_FLAGS})
target_link_options(${CMAKE_PROJECT_NAME}.elf PRIVATE ${MCU_FLAGS}
  -T /home/seer/project/PracticeFor/extern/Firmware/ldscripts/gd32f10x_flash.ld)

add_custom_command(TARGET ${CMAKE_PROJECT_NAME}.elf POST_BUILD
  COMMAND ${CMAKE_OBJCOPY} -Oihex ${CMAKE_PROJECT_NAME}.elf ${CMAKE_PROJECT_NAME}.hex
  COMMAND ${CMAKE_OBJCOPY} -Obinary ${CMAKE_PROJECT_NAME}.elf ${CMAKE_PROJECT_NAME}.bin)
