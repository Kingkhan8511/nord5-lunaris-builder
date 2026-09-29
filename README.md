# OnePlus Nord 5 (`lexus`) - Lunaris AOSP Builder (100% Free on GitHub)

Build **Lunaris AOSP (Android 16.2)** for **OnePlus Nord 5 (`lexus`)** directly on **GitHub Actions** without any credit card, VPS, or third-party approval!

---

## ⚡ 3 Simple Steps to Build (No Card, No External Server)

### Step 1: Create a GitHub Repo & Push this Code
1. Open [github.com/new](https://github.com/new) and create a repository (e.g. `nord5-lunaris-builder`).
2. Run these commands:
   ```bash
   git remote add origin https://github.com/<YOUR_GITHUB_USERNAME>/<REPO_NAME>.git
   git branch -M main
   git push -u origin main
   ```

### Step 2: Enable Workflow Write Permissions (10-second setting)
1. Go to your GitHub repository **Settings** tab.
2. Click **Actions** > **General** on the left menu.
3. Scroll down to **Workflow permissions**.
4. Select **"Read and write permissions"** and check **"Allow GitHub Actions to create and approve pull requests"**.
5. Click **Save**.

### Step 3: Run the Build!
1. Go to the **Actions** tab in your repository.
2. In the left sidebar, click: **"Build ROM Directly on GitHub Actions (No External Server Needed)"**.
3. Click the **Run workflow** button on the right.
4. Click the green **Run workflow** button.

---

## 📦 What Happens Next?
1. The GitHub Action runner frees up ~70 GB disk space and creates a 10 GB swap file.
2. It shallow-syncs Lunaris AOSP and OnePlus Nord 5 (`lexus`) trees (`device/oneplus/lexus`, `vendor`, `kernel`, `hardware/oplus`).
3. It compiles the ROM using all runner cores.
4. Once finished, it publishes the flashable ROM `.zip` under your GitHub repo's **Releases** page and prints a **Direct Mobile Download Link**!
