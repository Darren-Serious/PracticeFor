# 设置 CMake 最低支持版本 
cmake_minimum_required(VERSION 3.17) 
# Cmake 交叉编译配置 
set(CMAKE_SYSTEM_NAME Generic) 
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_C_STANDARD 99)
# Debug 模式 
set(CMAKE_BUILD_TYPE "Debug") 
# Release 模式 
# SET(CMAKE_BUILD_TYPE "Release")

# 设置 C 编译工具 
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
set(CMAKE_ASM_COMPILER arm-none-eabi-gcc)
# ELF 转换为 bin 和 hex 文件工具
set(CMAKE_OBJCOPY arm-none-eabi-objcopy)
set(CMAKE_OBJDUMP arm-none-eabi-objdump)
# 查看文件大小工具 
set(CMAKE_SIZE arm-none-eabi-size)
set(CMAKE_AR arm-none-eabi-ar) # 可用来编译静态库


set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

#内核相关
set(CPU "-mcpu=cortex-m3")
set(CPU_ARCH "-mthumb -mthumb-interwork")   # 生成thumb目标，arm和thumb可交叉调用
set(FPU "-mfpu=fpv4-sp-d16")
set(FPU_MEATHOD "-fsingle-precision-constant")
set(FLOAT_ABI "-mfloat-abi=softfp")

# 设置浮点选项 
SET(MCU_FLAGS "-mcpu=cortex-m3 -mfloat-abi=softfp -mfpu=fpv4-sp-d16") 
# set(MCU_FLAGS "${CPU} ${CPU_ARCH} ${FPU} ${FPU_MEATHOD} ${FLOAT_ABI}")
# 设置警告相关信息 
# SET(CMAKE_C_FLAGS "${MCU_FLAGS} -w -Wno-unknown-pragmas") 
set(CMAKE_C_FLAGS "${MCU_FLAGS} -std=gnu99 -Wall -fstack-usage -Wstack-usage=512 -fdata-sections -ffunction-sections -fno-common -fmessage-length=0 ${DBG_FLAGS} " CACHE INTERNAL "C compiler flags")
#CPP 
set(CMAKE_CXX_FLAGS "${MCU_FLAGS} -fno-rtti -fno-exceptions -fno-builtin -Wall -fdata-sections -ffunction-sections ${DBG_FLAGS} " CACHE INTERNAL "Cxx compiler flags")
#ASFLAGS
set(CMAKE_ASM_FLAGS "${MCU_FLAGS} -x assembler-with-cpp ${DBG_FLAGS} " CACHE INTERNAL "ASM compiler flags")
# -specs=nosys.specs //使用静态库 libnosys.a  -specs=nano.specs //使用静态库 libc_nano.a
# libnosys.a用于串口重定向，libc_nano.a用于降低ram和rom的使用
# --cref  :Cross Reference的简写，输出交叉引用表（cross reference table）
# -Wl,option　　把选项 option 传递给连接器。如果 option 中含有逗号，就在逗号处分割成多个选项
# --wrap=symbol 允许对标准库中已经定义的函数(假设为symbol)再加一层封装，这样编译器在进行函数调用的解引用的时候，
# 对symbol的解引用会被解析成__wrap_symbol，而如果你要使用真正的标准库里的函数，在调用symbol的时候必须要写成__real_symbol才可以
 
set(CMAKE_EXE_LINKER_FLAGS "${MCU_FLAGS} -specs=nosys.specs -specs=nano.specs -Wl,--print-memory-usage,-Map=${PROJECT_NAME}.map,--cref -Wl,--gc-sections" CACHE INTERNAL "Exe linker flags")
# 设置调试选项 
SET(CMAKE_C_FLAGS_DEBUG "-O0 -g2 -ggdb") 
SET(CMAKE_C_FLAGS_RELEASE "-O3") 
# 添加宏定义 
ADD_DEFINITIONS( 
    -DGD32F10X_HD
    -DUSE_STDPERIPH_DRIVER
)