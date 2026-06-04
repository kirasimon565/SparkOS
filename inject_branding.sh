#!/bin/bash
# SparkOS Framework Injection Script

AOSP_DIR="."

echo "======================================================="
echo "   REWRITING GOOGLE AOSP SYSTEM STRINGS FOR SPARKOS    "
echo "======================================================="

# 1. Modify the Build Display ID (What shows in Settings > About Phone)
BUILD_PROP="$AOSP_DIR/build/make/core/sysprop.mk"
if [ -f "$BUILD_PROP" ]; then
    sed -i 's/BUILD_DISPLAY_ID := .*/BUILD_DISPLAY_ID := SparkOS-Alpha-v1.0/g' "$BUILD_PROP"
    echo "-> Successfully modified Build Display ID."
fi

# 2. Modify system core product variables cosmetically
PRODUCT_CONFIG="$AOSP_DIR/build/make/target/product/aosp_arm64.mk"
if [ -f "$PRODUCT_CONFIG" ]; then
    echo "-> Purging cached workspace modifications from previous runs..."
    # FORCE HEAL: Restores the core compiler targets to their exact stock names
    sed -i 's/PRODUCT_NAME := .*/PRODUCT_NAME := aosp_arm64/g' "$PRODUCT_CONFIG"
    sed -i 's/PRODUCT_DEVICE := .*/PRODUCT_DEVICE := generic_arm64/g' "$PRODUCT_CONFIG"
    echo "-> Workspace corruption cleared. Targets reset to generic_arm64."

    # Now apply the completely safe cosmetic visibility variables
    sed -i 's/PRODUCT_BRAND := .*/PRODUCT_BRAND := SparkOS/g' "$PRODUCT_CONFIG"
    sed -i 's/PRODUCT_MANUFACTURER := .*/PRODUCT_MANUFACTURER := SparkOS/g' "$PRODUCT_CONFIG"
    
    # Safely injecting custom model names for the settings display page
    if grep -q "PRODUCT_MODEL" "$PRODUCT_CONFIG"; then
        sed -i 's/PRODUCT_MODEL := .*/PRODUCT_MODEL := SparkOS Alpha/g' "$PRODUCT_CONFIG"
    else
        echo "PRODUCT_MODEL := SparkOS Alpha" >> "$PRODUCT_CONFIG"
    fi
    echo "-> Successfully modified Core Product Variables."
fi

echo "Framework modifications complete. SparkOS variables locked."
