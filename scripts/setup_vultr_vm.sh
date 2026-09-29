#!/usr/bin/env bash
# ==============================================================================
# OnePlus Nord 5 (lexus) - Lunaris AOSP Build Script for Vultr / Ubuntu VM
# ==============================================================================
set -e

echo ">>> [1/5] Updating system and installing AOSP build dependencies..."
apt-get update -y
apt-get install -y \
    bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs \
    gnupg gperf imagemagick lib32readline-dev lib32z1-dev libelf-dev liblz4-tool \
    libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils \
    lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev \
    python3 python-is-python3 openjdk-17-jdk unzip libtinfo5 jq

# Install Google Repo tool
mkdir -p /usr/local/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/local/bin/repo
chmod a+x /usr/local/bin/repo

# Git configuration
git config --global user.name "Lunaris Builder"
git config --global user.email "builder@nord5.local"

echo ">>> [2/5] Initializing Lunaris AOSP repository..."
mkdir -p /root/rom
cd /root/rom

repo init -u https://github.com/Lunaris-AOSP/android.git -b 16.2 --git-lfs --depth=1

echo ">>> [3/5] Setting up local manifests for OnePlus Nord 5 (lexus)..."
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

echo ">>> [4/5] Syncing repositories..."
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

echo ">>> [5/5] Compiling Lunaris AOSP for OnePlus Nord 5..."
source build/envsetup.sh
lunch lunaris_lexus-userdebug || lunch lineage_lexus-userdebug || lunch lexus-userdebug

m bacon -j$(nproc --all)

echo "============================================================"
echo " BUILD FINISHED SUCCESSFULLY!"
ROM_ZIP=$(ls out/target/product/lexus/*.zip 2>/dev/null | head -n 1)
if [ -n "$ROM_ZIP" ]; then
    echo "ROM File: $ROM_ZIP"
    echo "Uploading ROM for instant mobile download link..."
    curl https://bashupload.com/ -T "$ROM_ZIP" || true
fi
echo "============================================================"
