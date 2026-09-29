# Custom ROM Builder for OnePlus Nord 5 (GitHub Actions)

This repository contains automated GitHub Actions workflows to compile custom Android ROMs (such as LineageOS, crDroid, PixelOS) for the **OnePlus Nord 5** (codename `lexus`).

---

## ⚠️ Important Note About GitHub Actions Runner Limits

Standard GitHub Actions runners only provide ~30 GB of usable disk space and 7 GB RAM with a 6-hour limit. Full Android source sync and compilation requires **~250 GB - 350 GB disk space** and **16 GB - 32 GB RAM**.

To build successfully, you have two options:
1. **Option A (Recommended & Free): Crave.io via GitHub Actions**
   - Uses Crave's dedicated high-performance build servers (64-core, 500GB+ storage).
   - Fully free for open-source custom ROM development.
2. **Option B: GitHub Self-Hosted Runner**
   - Connect your own Linux PC or rented VPS to GitHub Actions.

---

## Quick Setup Guide

### Step 1: Trees Required
Make sure you have the Git repository URLs for:
* **Device Tree**: `https://github.com/<your-user>/device_oneplus_lexus` (Path: `device/oneplus/lexus`)
* **Vendor Tree**: `https://github.com/<your-user>/vendor_oneplus_lexus` (Path: `vendor/oneplus/lexus`)
* **Kernel Tree**: `https://github.com/<your-user>/kernel_oneplus_smXXXX` (Path: `kernel/oneplus/smXXXX` or prebuilt)

### Step 2: Configure Crave.io (If using Option A)
1. Sign up at [crave.io](https://crave.io).
2. Go to your Account Settings and download your `crave.conf` or get your API token.
3. In your GitHub repository, go to **Settings > Secrets and variables > Actions**.
4. Add the following repository secrets:
   * `CRAVE_USERNAME`: Your Crave username
   * `CRAVE_API_KEY`: Your Crave API key or token

### Step 3: Trigger Build
1. Go to the **Actions** tab on your GitHub repository.
2. Select **Build Custom ROM (Crave.io)**.
3. Click **Run workflow**, enter your ROM source URL, branch, and device target.
