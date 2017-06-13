////////////////////////////////////////////////////////////////////////////////
//
//  FFTSTest - Test FFTS
//
//  Copyright (C) 2015	Bill Farmer
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//  Bill Farmer	 william j farmer [at] yahoo [dot] co [dot] uk.
//
///////////////////////////////////////////////////////////////////////////////

#include <jni.h>
#include <dlfcn.h>
#include <stdio.h>
#include <string.h>
#include <android/log.h>
#include <cpu-features.h>

#define LOGI(tag, ...) __android_log_print(ANDROID_LOG_INFO, tag, __VA_ARGS__)
#define printf(...) LOGI("FFTS Test", __VA_ARGS__); \
    sprintf(line, __VA_ARGS__);	\
    strcat(text, line)

char text[4096] = "";
char line[256] = "";

extern int main(int argc, char *argv[]);

jstring
Java_org_billthefarmer_fftstest_Main_main(JNIEnv *env,
					  jobject obj)
{
    strcpy(text, "");
    printf("FFTS Test\n");

    if (android_getCpuFamily() == ANDROID_CPU_FAMILY_ARM &&
        (android_getCpuFeatures() & ANDROID_CPU_ARM_FEATURE_NEON) != 0)
    {
	printf("NEON processor\n");
	dlopen("libfft-neon.so", RTLD_NOW);
    }
    // use NEON-optimized routines

    else
    {
	printf("VFP processor");
	dlopen("libfft-vfp.so", RTLD_NOW);
    }

    // use non-NEON fallback routines instead

    main(0, NULL);

    return (*env)->NewStringUTF(env, text);
}
