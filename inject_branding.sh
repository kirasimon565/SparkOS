#!/bin/bash
# SparkOS Framework Injection Script

AOSP_DIR="$HOME/aosp"

echo "======================================================="
echo "   REWRITING GOOGLE AOSP SYSTEM STRINGS FOR SPARKOS    "
echo "======================================================="

# 1. Modify the Build Display ID (What shows in Settings > About Phone)
BUILD_PROP="$AOSP_DIR/build/make/core/sysprop.mk"
if [ -f "$BUILD_PROP" ]; then
    sed -i 's/BUILD_DISPLAY_ID := .*/BUILD_DISPLAY_ID := SparkOS-Alpha-v1.0/g' $BUILD_PROP
fi

# 2. Modify system core product variables
PRODUCT_CONFIG="$AOSP_DIR/build/make/target/product/aosp_arm64.mk"
if [ -f "$PRODUCT_CONFIG" ]; then
    sed -i 's/PRODUCT_NAME := .*/PRODUCT_NAME := sparkos_arm64/g' $PRODUCT_CONFIG
    sed -i 's/PRODUCT_BRAND := .*/PRODUCT_BRAND := SparkOS/g' $PRODUCT_CONFIG
    sed -i 's/PRODUCT_MANUFACTURER := .*/PRODUCT_MANUFACTURER := SparkOS/g' $PRODUCT_CONFIG
    sed -i 's/PRODUCT_DEVICE := .*/PRODUCT_DEVICE := sparkos_arm64/g' $PRODUCT_CONFIG
fi

echo "Framework modifications complete. SparkOS variables locked."
