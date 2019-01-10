#
# Copyright (c) 2019 The nanoFramework project contributors
# See LICENSE file in the project root for full license information.
#

# check for touch sensor driver in target directory so we can display a meaningfull message
# TODO FIXME
# if(NOT EXISTS "${TARGET_BASE_LOCATION}/UI.Display/SPI/CPU_To_Graphics_Display.cpp")
#     message(FATAL_ERROR, "\nCPU to Graphics display not found in target directory.\n")
# endif()

# check for touch sensor driver so we can display a meaningfull message
if(NOT EXISTS "${PROJECT_SOURCE_DIR}/src/DeviceDrivers/UI/Touch/${UI_TOUCH_SENSOR}/Touch_driver.cpp")
    message(FATAL_ERROR, "\nTouch sensor driver not found in device drivers directory.\n")
endif()

# set include directories
list(APPEND NF_UI_Touch_INCLUDE_DIRS "${PROJECT_SOURCE_DIR}/src/DeviceInterfaces/UI.Touch/Bmp")
list(APPEND NF_UI_Touch_INCLUDE_DIRS "${PROJECT_SOURCE_DIR}/src/DeviceInterfaces/UI.Touch/Includes")
list(APPEND NF_UI_Touch_INCLUDE_DIRS "${PROJECT_SOURCE_DIR}/src/DeviceDrivers/UI/Includes")
list(APPEND NF_UI_Touch_INCLUDE_DIRS "${PROJECT_SOURCE_DIR}/src/DeviceDrivers/UI/Includes/${UI_TOUCH_SENSOR}")

# source files
set(NF_UI_Touch_SRCS

    TouchPanelDriver.cpp
    TouchPanelFunctions.cpp
                
    touch_native_Touch_TouchCollectorConfiguration.cpp
    touch_native_Touch_TouchEventProcessor.cpp
    touch_native_Touch_TouchPanel.cpp
    touch_native.cpp

    Ink_driver.cpp
    ink_functions.cpp
    touch_native_Touch_Ink.cpp

    Touch_driver.cpp
    Touch_functions.cpp
)

foreach(SRC_FILE ${NF_UI_Touch_SRCS})
    set(NF_UI_Touch_SRC_FILE SRC_FILE-NOTFOUND)
    find_file(NF_UI_Touch_SRC_FILE ${SRC_FILE}
        PATHS

            "${PROJECT_SOURCE_DIR}/src/DeviceInterfaces/UI.Touch/Core"
            "${PROJECT_SOURCE_DIR}/src/DeviceInterfaces/UI.Touch/Native"
            "${PROJECT_SOURCE_DIR}/src/DeviceInterfaces/UI.Touch/Ink"
           
            "${PROJECT_SOURCE_DIR}/src/DeviceDrivers/UI/Touch/${UI_TOUCH_SENSOR}"
 
        CMAKE_FIND_ROOT_PATH_BOTH
    )
    # message("${SRC_FILE} >> ${NF_UI_Touch_SRC_FILE}") # debug helper
    list(APPEND NF_UI_Touch_SOURCES ${NF_UI_Touch_SRC_FILE})
endforeach()

include(FindPackageHandleStandardArgs)

FIND_PACKAGE_HANDLE_STANDARD_ARGS(NF_UI_Touch DEFAULT_MSG NF_UI_Touch_INCLUDE_DIRS NF_UI_Touch_SOURCES)
