#!/usr/bin/env bash
set -e

ROM_MANIFEST="${1:-https://github.com/Lunaris-AOSP/android.git}"
ROM_BRANCH="${2:-16.2}"
DEVICE_CODENAME="${3:-lexus}"
BUILD_TYPE="${4:-userdebug}"
BUILD_COMMAND="${5:-m bacon}"

echo "=================================================="
echo "Starting Custom ROM Build: Lunaris AOSP"
echo "Device: $DEVICE_CODENAME"
echo "Manifest: $ROM_MANIFEST ($ROM_BRANCH)"
echo "Build Type: $BUILD_TYPE"
echo "Command: $BUILD_COMMAND"
echo "=================================================="

# 1. Initialize repo
repo init -u "$ROM_MANIFEST" -b "$ROM_BRANCH" --git-lfs --depth=1

# 2. Setup Local Manifests
mkdir -p .repo/local_manifests
cat << 'EOF' > .repo/local_manifests/nord5.xml
<?xml version="1.0" encoding="UTF-8"?>
<manifest>
    <remote name="github" fetch="https://github.com" />

    <!-- OnePlus Nord 5 (lexus) Device Tree -->
    <project path="device/oneplus/lexus" 
             name="LineageOS/android_device_oneplus_lexus" 
             remote="github" 
             revision="lineage-22.1" />

    <!-- OnePlus SM8650 Common Device Tree -->
    <project path="device/oneplus/sm8650-common" 
             name="LineageOS/android_device_oneplus_sm8650-common" 
             remote="github" 
             revision="lineage-22.1" />

    <!-- OnePlus Nord 5 (lexus) Vendor Blobs -->
    <project path="vendor/oneplus/lexus" 
             name="TheMuppets/proprietary_vendor_oneplus_lexus" 
             remote="github" 
             revision="lineage-22.1" />

    <!-- OnePlus SM8650 Common Vendor Blobs -->
    <project path="vendor/oneplus/sm8650-common" 
             name="TheMuppets/proprietary_vendor_oneplus_sm8650-common" 
             remote="github" 
             revision="lineage-22.1" />

    <!-- OnePlus SM8650 Kernel Source -->
    <project path="kernel/oneplus/sm8650" 
             name="LineageOS/android_kernel_oneplus_sm8650" 
             remote="github" 
             revision="lineage-22.1" />

    <!-- OnePlus/Oplus Hardware HALs -->
    <project path="hardware/oplus" 
             name="LineageOS/android_hardware_oplus" 
             remote="github" 
             revision="lineage-22.1" />
</manifest>
EOF

# 3. Sync source and trees
echo "Syncing repositories..."
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

# 4. Setup environment and lunch
echo "Setting up environment..."
source build/envsetup.sh

echo "Lunching target..."
lunch lunaris_${DEVICE_CODENAME}-${BUILD_TYPE} || \
lunch lineage_${DEVICE_CODENAME}-${BUILD_TYPE} || \
lunch ${DEVICE_CODENAME}-${BUILD_TYPE}

# 5. Build
echo "Starting compilation..."
eval "$BUILD_COMMAND"
