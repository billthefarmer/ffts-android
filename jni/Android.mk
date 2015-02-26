LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := ffts
LOCAL_CFLAGS := -Ijni/include -Ijni/src -DHAVE_DECL_MEMALIGN -std=c99 \
	-Wno-pointer-to-int-cast -Wno-int-to-pointer-cast
LOCAL_SRC_FILES := \
	ffts_jni.c \
	src/ffts.c \
	src/ffts_nd.c \
	src/ffts_real.c \
	src/ffts_real_nd.c \
	src/ffts_small.c \
	src/patterns.c
LOCAL_LDLIBS := -llog 

#ifeq ($(TARGET_ARCH_ABI),armeabi)
#LOCAL_CFLAGS += -DDYNAMIC_DISABLED
#LOCAL_SRC_FILES += \
#	src/ffts_static.c
#endif

ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_CFLAGS += -DHAVE_VFP
LOCAL_SRC_FILES += \
	src/codegen.c \
	src/vfp.s
endif

include $(BUILD_SHARED_LIBRARY)
