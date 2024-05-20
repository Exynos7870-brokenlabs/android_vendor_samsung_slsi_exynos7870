#
# Copyright (C) 2014 The Android Open Source Project
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
LOCAL_MODULE := mobicorebin
LOCAL_MODULE_TAGS := optional
LOCAL_REQUIRED_MODULES := ffffffffd00000000000000000000016.tlbin \
    07010000000000000000000000000000.tlbin \
    08130000000000000000000000000000.tlbin \
    00060308060501020000000000000000.tlbin \
    FFFFFFFF000000000000000000000001.drbin \
    ffffffff000000000000000000000004.tlbin \
    ffffffffd00000000000000000000004.tlbin \
    ffffffff000000000000000000000005.tlbin \
    ffffffff00000000000000000000000c.tlbin \
    ffffffff00000000000000000000000d.tlbin \
    ffffffff000000000000000000000016.tlbin \
    fffffffff0000000000000000000001e.tlbin \
    ffffffff000000000000000000000017.tlbin

##### Sem feature #####
ifeq (true,$(call spf_check,SEC_PRODUCT_FEATURE_SECURITY_CONFIG_ESE_CHIP_VENDOR,GEMALTO))
SEM_VENDOR := gem
endif

ifeq (true, $(findstring true, $(call spf_check,SEC_PRODUCT_FEATURE_SECURITY_CONFIG_ESE_CHIP_VENDOR,GEMALTO) ))
LOCAL_REQUIRED_MODULES += \
    fffffffff0000000000000000000001b.tlbin \
    ffffffffd00000000000000000000017.tlbin     	
endif

SEM_DIR := sem/$(SEM_VENDOR)
SEM_SPIDRV_DIR := sem/spidrv/$(SEM_VENDOR)
##### end of Sem feature #####

#TUI Secure Driver
ifeq ($(PROJECT_NAME),$(filter $(PROJECT_NAME), a3y17lte))
LOCAL_REQUIRED_MODULES += \
    ffffffffd00000000000000000000014.tlbin
TSP_IC = imagis
TUI_DIR := tui/$(TSP_IC)
endif
#end of TUI feature

ifeq ($(TIMA_ENABLED),1)

ifeq ($(TIMA_VERSION),3)
TIMA_DIR = tima3
else
# default TIMA_DIR is tima2
TIMA_DIR = tima2
endif

LOCAL_REQUIRED_MODULES += \
    ffffffff000000000000000000000019.tlbin \
    ffffffffd0000000000000000000000a.tlbin \
    ffffffff00000000000000000000000a.tlbin \
    ffffffff00000000000000000000000f.tlbin

ifeq ($(TIMA_VERSION),3)
LOCAL_REQUIRED_MODULES += \
    ffffffff000000000000000000000012.tlbin \
    ffffffff000000000000000000000013.tlbin \
    ffffffff00000000000000000000000b.tlbin \
    ccm_gen_cert

# ICCC
ifeq (true,$(call spf_check,SEC_PRODUCT_FEATURE_KNOX_SUPPORT_ICCC,TRUE))
LOCAL_REQUIRED_MODULES += \
    ffffffff000000000000000000000041.tlbin
endif

endif
endif

# Fingerprint Feature
ifneq ($(SEC_BUILD_CONF_USE_FINGERPRINT_TZ),false)
LOCAL_REQUIRED_MODULES += \
    ffffffff00000000000000000000000e.tlbin \
    ffffffff00000000000000000000002e.tlbin \
    ffffffffd0000000000000000000000e.tlbin
ifeq ($(SEC_BUILD_CONF_USE_FINGERPRINT_TZ),mc_raptor)
FINGERPRINT_DIR := fingerprint/raptor
else ifeq ($(SEC_BUILD_CONF_USE_FINGERPRINT_TZ),mc_raptor_newdb)
FINGERPRINT_DIR := fingerprint/raptor/newdb
else ifeq ($(SEC_BUILD_CONF_USE_FINGERPRINT_TZ),mc_vigis)
FINGERPRINT_DIR := fingerprint/vigis
else ifeq ($(SEC_BUILD_CONF_USE_FINGERPRINT_TZ),mc_vigis_mos)
FINGERPRINT_DIR := fingerprint/vigis_mos
else ifeq ($(SEC_BUILD_CONF_USE_FINGERPRINT_TZ),mc_viper_samsung)
FINGERPRINT_DIR := fingerprint/viper_samsung
else ifeq ($(SEC_BUILD_CONF_USE_FINGERPRINT_TZ),mc_viper_samsung_mos)
FINGERPRINT_DIR := fingerprint/viper_samsung_mos
else ifeq ($(SEC_BUILD_CONF_USE_FINGERPRINT_TZ),mc_et510_egis_mos)
FINGERPRINT_DIR := fingerprint/et510_egis_mos
else
FINGERPRINT_DIR := fingerprint/vigis
endif
endif # end of Fingerprint Feature

include $(BUILD_PHONY_PACKAGE)

include $(CLEAR_VARS)
LOCAL_MODULE := ffffffffd00000000000000000000016.tlbin
LOCAL_SRC_FILES := $(KEYMANAGER_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT) 

include $(CLEAR_VARS)
LOCAL_MODULE := ffffffff000000000000000000000005.tlbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := 07010000000000000000000000000000.tlbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT) 


#Gatekeeper
include $(CLEAR_VARS)
LOCAL_MODULE := 08130000000000000000000000000000.tlbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

#Secure Driver
include $(CLEAR_VARS)
LOCAL_MODULE := FFFFFFFF000000000000000000000001.drbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)
include $(BUILD_PREBUILT)

#MLDAP
include $(CLEAR_VARS)
LOCAL_MODULE := ffffffff000000000000000000000017.tlbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

# DRK modules - Prov.
include $(CLEAR_VARS)
LOCAL_MODULE := ffffffff00000000000000000000000c.tlbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

# DRK modules - Skm.
include $(CLEAR_VARS)
LOCAL_MODULE := ffffffff00000000000000000000000d.tlbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

#Widevine
include $(CLEAR_VARS)
LOCAL_MODULE := 00060308060501020000000000000000.tlbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

ifeq ($(TIMA_ENABLED),1)

include $(CLEAR_VARS)
LOCAL_MODULE := ffffffff000000000000000000000019.tlbin
LOCAL_SRC_FILES := $(TIMA_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := ffffffffd0000000000000000000000a.tlbin
LOCAL_SRC_FILES := $(TIMA_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := ffffffff00000000000000000000000a.tlbin
LOCAL_SRC_FILES := $(TIMA_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := ffffffff00000000000000000000000f.tlbin
LOCAL_SRC_FILES := $(TIMA_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

ifeq ($(TIMA_VERSION),3)

include $(CLEAR_VARS)
LOCAL_MODULE := ccm_gen_cert
LOCAL_SRC_FILES := $(TIMA_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT)/bin
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := ffffffff000000000000000000000012.tlbin
LOCAL_SRC_FILES := $(TIMA_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := ffffffff000000000000000000000013.tlbin
LOCAL_SRC_FILES := $(TIMA_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := ffffffff00000000000000000000000b.tlbin
LOCAL_SRC_FILES := $(TIMA_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

ifeq (true,$(call spf_check,SEC_PRODUCT_FEATURE_KNOX_SUPPORT_ICCC,TRUE))
include $(CLEAR_VARS)
LOCAL_MODULE := ffffffff000000000000000000000041.tlbin
LOCAL_SRC_FILES := $(TIMA_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)
endif

endif
endif

# Fingerprint Feature
ifneq ($(SEC_BUILD_CONF_USE_FINGERPRINT_TZ),false)
include $(CLEAR_VARS)
LOCAL_MODULE := ffffffff00000000000000000000000e.tlbin
LOCAL_SRC_FILES := $(FINGERPRINT_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := ffffffff00000000000000000000002e.tlbin
LOCAL_SRC_FILES := $(FINGERPRINT_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := ffffffffd0000000000000000000000e.tlbin
LOCAL_SRC_FILES := $(FINGERPRINT_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)
endif # end of Fingerprint Feature

#### SEM TA, secure drv start ####
ifeq (true, $(findstring true, $(call spf_check,SEC_PRODUCT_FEATURE_SECURITY_CONFIG_ESE_CHIP_VENDOR,GEMALTO) ))
# sem TA
include $(CLEAR_VARS)
LOCAL_MODULE := fffffffff0000000000000000000001b.tlbin
LOCAL_SRC_FILES := $(SEM_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

# sem SPI secdrv
include $(CLEAR_VARS)
LOCAL_MODULE := ffffffffd00000000000000000000017.tlbin
LOCAL_SRC_FILES := $(SEM_SPIDRV_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)
endif
#### SEM TA, secure drv end ####

# Secure Storage
include $(CLEAR_VARS)
LOCAL_MODULE := ffffffff000000000000000000000004.tlbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := ffffffffd00000000000000000000004.tlbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

# SKMM_TA
include $(CLEAR_VARS)
LOCAL_MODULE := ffffffff000000000000000000000016.tlbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

#OTP 
include $(CLEAR_VARS)
LOCAL_MODULE := fffffffff0000000000000000000001e.tlbin
LOCAL_SRC_FILES := $(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)

#TUI Secure Driver
ifeq ($(PROJECT_NAME),$(filter $(PROJECT_NAME), a3y17lte))
include $(CLEAR_VARS)
LOCAL_MODULE := ffffffffd00000000000000000000014.tlbin
LOCAL_SRC_FILES := $(TUI_DIR)/$(LOCAL_MODULE)
LOCAL_MODULE_CLASS := ETC
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE_PATH := $(TARGET_OUT_APPS)/mcRegistry
include $(BUILD_PREBUILT)
endif

