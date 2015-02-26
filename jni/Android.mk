LOCAL_PATH := $(call my-dir)

#TOP=../../..

# Include the shared library
#include $(CLEAR_VARS)
#LOCAL_MODULE := ffts
#LOCAL_SRC_FILES :=  ../../../src/.libs/libffts.so
#include $(PREBUILT_SHARED_LIBRARY)

# Include the static library in shared lib
#include $(CLEAR_VARS)
#LOCAL_MODULE := ffts
#LOCAL_SRC_FILES := $(TOP)/java/android/bin/lib/libffts.a
#LOCAL_EXPORT_C_INCLUDES := $(TOP)/include
#include $(PREBUILT_STATIC_LIBRARY)

#include $(CLEAR_VARS)
#LOCAL_MODULE := ffts_jni
#LOCAL_CFLAGS := -I$(TOP)/include -I$(TOP)/java/jni -I$(TOP) -Wno-pointer-to-int-cast -Wno-int-to-pointer-cast
#LOCAL_SRC_FILES := $(TOP)/java/jni/ffts_jni.c
#LOCAL_LDLIBS := -L$(SYSROOT)/usr/lib -llog 
#LOCAL_STATIC_LIBRARIES := ffts

#include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := ffts
LOCAL_CFLAGS := -Ijni/include -Ijni/src -DHAVE_DECL_MEMALIGN -std=c99 \
	-Wno-pointer-to-int-cast -Wno-int-to-pointer-cast
LOCAL_SRC_FILES := \
	ffts_jni.c \
	src/codegen.c \
	src/ffts.c \
	src/ffts_nd.c \
	src/ffts_real.c \
	src/ffts_real_nd.c \
	src/ffts_small.c \
	src/ffts_static.c \
	src/patterns.c
LOCAL_LDLIBS := -llog 

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_CFLAGS += -mfpu=neon -DHAVE_NEON
LOCAL_SRC_FILES += \
	src/neon.s \
	src/neon_static_f.s \
	src/neon_static_i.s
endif

include $(BUILD_SHARED_LIBRARY)
