#ifdef ANDROID
#include <jni.h>
#include <cpu-features.h>

JNIEXPORT jboolean JNICALL Java_nz_ac_waikato_ffts_FFTS_has_neon
(JNIEnv *env, jclass jc)
{
    if (android_getCpuFamily() == ANDROID_CPU_FAMILY_ARM &&
        (android_getCpuFeatures() & ANDROID_CPU_ARM_FEATURE_NEON) != 0)
	return JNI_TRUE;
    
    // use NEON-optimized routines

    else
	return JNI_FALSE;

    // use non-NEON fallback routines instead
}
#endif
