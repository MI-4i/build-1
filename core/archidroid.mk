#######################
### GENERAL SECTION ###
#######################

# General optimization level
ARCHIDROID_GCC_CFLAGS_OPTI := -O3

# General optimization level of target ARM compiled with GCC. Default: -O2
ARCHIDROID_GCC_CFLAGS_ARM := $(ARCHIDROID_GCC_CFLAGS_OPTI)

# General optimization level of target THUMB compiled with GCC. Default: -Os
ARCHIDROID_GCC_CFLAGS_THUMB := $(ARCHIDROID_GCC_CFLAGS_OPTI)

# Additional flags passed to all C targets compiled with GCC
ifneq (1,$(words $(filter $(DISABLE),$(LOCAL_MODULE))))
ARCHIDROID_GCC_CFLAGS := $(ARCHIDROID_GCC_CFLAGS_OPTI)
else
ARCHIDROID_GCC_CFLAGS := $(ARCHIDROID_GCC_CFLAGS_OPTI) -fmodulo-sched -fmodulo-sched-allow-regmoves -g0
endif

DISABLE := \
libvorbisidec

# Bluetooth does crash if you compile with -O3
ifneq (1,$(words $(filter $(BLUETOOTH),$(LOCAL_MODULE))))
ARCHIDROID_GCC_CFLAGS_THUMB := -Os
endif

BLUETOOTH := \
	bluetooth.default \

# We also need to disable some warnings to not abort the build - those warning are not critical
ARCHIDROID_GCC_CFLAGS += -Wno-error=array-bounds -Wno-error=clobbered -Wno-error=maybe-uninitialized -Wno-error=parentheses -Wno-error=strict-overflow -Wno-error=unused-variable -Wno-error=error

# Flags passed to linker (ld) of all C and C++ targets
ARCHIDROID_GCC_LDFLAGS := -Wl,-O3 -Wl,--as-needed -Wl,--gc-sections -Wl,--relax -Wl,--sort-common


# Flags below are applied to specific targets only, use them if your flag is not compatible for both compilers

# We use GCC 5.3 for arm-linux-androideabi, make sure to remove flags below if you decided to stick with 4.9
ARCHIDROID_GCC_CFLAGS_32 := -mtune=cortex-a15

# We use GCC 4.9 for aarch64-linux-android, so we don't have any extra flags for it
ifeq (arm,$(TARGET_ARCH))
ARCHIDROID_GCC_CFLAGS_64 := -mtune=cortex-a57.cortex-a53
endif

####################
### MISC SECTION ###
####################

# Flags passed to GCC preprocessor for C and C++
ARCHIDROID_GCC_CPPFLAGS := $(ARCHIDROID_GCC_CFLAGS)

#####################
### CLANG SECTION ###
#####################

# Flags passed to all C targets compiled with CLANG
ARCHIDROID_CLANG_CFLAGS := -O3 -Qunused-arguments -Wno-unknown-warning-option -mtune=cortex-a15

# Flags passed to CLANG preprocessor for C and C++
ARCHIDROID_CLANG_CPPFLAGS := $(ARCHIDROID_CLANG_CFLAGS)

# Flags passed to linker (ld) of all C and C++ targets compiled with CLANG
ARCHIDROID_CLANG_LDFLAGS := $(ARCHIDROID_GCC_LDFLAGS)

# Flags that are used by GCC, but are unknown to CLANG. If you get "argument unused during compilation" error, add the flag here
ARCHIDROID_CLANG_UNKNOWN_FLAGS := \
 	-fmodulo-sched \
  	-fmodulo-sched-allow-regmoves \
  	-ftree-loop-im \
  	-ftree-loop-ivcanon \
  	-funsafe-loop-optimizations \
  	-mvectorize-with-neon-quad \
  	-fpredictive-commoning \
  	-ftree-loop-vectorize \
  	-ftree-partial-pre \
  	-fipa-cp-clone \

ifneq (1,$(words $(filter $(LOCAL_DISABLE_STRICT),$(LOCAL_MODULE))))
ARCHIDROID_GCC_CFLAGS:= -fno-strict-aliasing
endif

LOCAL_DISABLE_STRICT := \
	libc_bionic \
	libc_dns \
	libc_tzcode \
	libziparchive \
	libtwrpmtp \
	libfusetwrp \
	libguitwrp \
	busybox \
	libuclibcrpc \
	libziparchive-host \
	libpdfiumcore \
	libandroid_runtime \
	libmedia \
	libpdfiumcore \
	libpdfium \
	bluetooth.default \
	logd \
	mdnsd \
	net_net_gyp \
	libstagefright_webm \
	libaudioflinger \
	libmediaplayerservice \
	libstagefright \
	ping \
	ping6 \
	libdiskconfig \
	libjavacore \
	libfdlibm \
	libvariablespeed \
	librtp_jni \
	libwilhelm \
	libdownmix \
	libldnhncr \
	libqcomvisualizer \
	libvisualizer \
	libutils \
	libandroidfw \
	dnsmasq \
	static_busybox \
	content_content_renderer_gyp \
	third_party_WebKit_Source_modules_modules_gyp \
	third_party_WebKit_Source_platform_blink_platform_gyp \
	third_party_WebKit_Source_core_webcore_remaining_gyp \
	third_party_angle_src_translator_lib_gyp \
	third_party_WebKit_Source_core_webcore_generated_gyp \
	libc_gdtoa \
	libc_openbsd \
	libc \
	libc_nomalloc \
	patchoat \
	dex2oat \
	libart \
	libart-compiler \
	oatdump \
	libart-disassembler \
	linker \
	camera.msm8084 \
	mm-vdec-omx-test \
	libc_malloc \
	libcutils \
	liblog \
	libbacktrace \
        libunwind \
        libbase \
        libbacktrace_test \
        backtrace_test \
	libc_bionic_ndk \
	libc_gdtoa \
	libc_openbsd_ndk \
	liblog \
	libc \
	libbt-brcm_stack \
	libandroid_runtime \
	libandroidfw \
	libosi \
	libnetlink \
        libext4 \
	clatd \
	ip \
        libnetlink \
        fio\
        tcpdump \
	libc_nomalloc \
	libnvvisualizer \
	libskia \
        libiprouteutil
