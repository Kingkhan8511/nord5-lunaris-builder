#!/usr/bin/env bash
# ==============================================================================
# OnePlus Nord 5 (lexus) - Lunaris AOSP Build Script for Google Cloud (GCP)
# ==============================================================================
set -e

echo ">>> [1/5] Updating system and installing AOSP build dependencies..."
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install -y \
    bc bison build-essential ccache curl flex g++-multilib gcc-multilib git git-lfs \
    gnupg gperf imagemagick lib32readline-dev lib32z1-dev libelf-dev liblz4-tool \
    libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils \
    lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev \
    python3 python-is-python3 openjdk-17-jdk unzip libtinfo5 jq

# Install Google Repo tool
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo
export PATH=~/bin:$PATH
echo 'export PATH=~/bin:$PATH' >> ~/.bashrc

# Git configuration
git config --global user.name "Lunaris Builder"
git config --global user.email "builder@nord5.local"

echo ">>> [2/5] Initializing Lunaris AOSP repository..."
mkdir -p ~/rom
cd ~/rom

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

echo ">>> [4/5] Syncing repositories (this may take 15-25 minutes on Google Cloud's 10Gbps network)..."
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags

echo ">>> [5/5] Compiling Lunaris AOSP for OnePlus Nord 5..."
source build/envsetup.sh
lunch lunaris_lexus-userdebug || lunch lineage_lexus-userdebug || lunch lexus-userdebug

m bacon -j$(nproc --all)

echo "============================================================"
echo " BUILD FINISHED SUCCESSFULLY!"
echo " ROM Output: $(ls -lh out/target/product/lexus/*.zip 2>/dev/null || echo 'Check out/target/product/lexus/')"
echo "============================================================"
