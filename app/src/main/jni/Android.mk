# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := ffts-neon
LOCAL_SRC_FILES := libs/$(TARGET_ARCH_ABI)/libffts-neon.so

include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE := ffts-vfp
LOCAL_SRC_FILES := libs/$(TARGET_ARCH_ABI)/libffts-vfp.so

include $(PREBUILT_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_MODULE    := fftstest
LOCAL_CFLAGS := -rdynamic
LOCAL_SRC_FILES := fftstest.c tests/test.c
LOCAL_SHARED_LIBRARIES := ffts-neon ffts-vfp
LOCAL_LDLIBS := -llog -ldl

LOCAL_STATIC_LIBRARIES := cpufeatures
include $(BUILD_SHARED_LIBRARY)

$(call import-module,android/cpufeatures)
