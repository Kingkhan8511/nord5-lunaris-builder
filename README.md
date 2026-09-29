# OnePlus Nord 5 (`lexus`) - Lunaris AOSP ROM Builder

Automated GitHub Actions CI/CD workflow to compile **Lunaris AOSP (Android 16.2)** for the **OnePlus Nord 5 (`lexus`)**.

---

## 📁 Project Structure

```text
├── .github/
│   └── workflows/
│       ├── build_crave.yml          # Cloud build via Crave.io (Recommended & Free)
│       └── build_self_hosted.yml    # Build on your own Linux server/runner
├── manifests/
│   └── nord5.xml                    # Local manifests for device, vendor, and kernel
├── scripts/
│   └── build_rom.sh                 # Unified build execution script
└── README.md
```

---

## 🚀 How to Run the Build (Step-by-Step)

### Step 1: Create a GitHub Repository & Push this Code
If you haven't pushed this repo to GitHub yet:
1. Create a new empty repository on [GitHub](https://github.com/new) (e.g. `nord5-lunaris-builder`).
2. Run these commands to push the code:
   ```bash
   git remote add origin https://github.com/<your-username>/<repo-name>.git
   git branch -M main
   git push -u origin main
   ```

---

### Step 2: Setup Free Cloud Build Server (Crave.io)
Android builds require ~300GB disk space and 16-32GB RAM. Crave.io gives this completely free for ROM building:
1. Sign up for free at [crave.io](https://crave.io).
2. Go to your **API Keys / Settings** and download your `crave.conf`.
3. Open your GitHub Repository:
   - Go to **Settings** > **Secrets and variables** > **Actions** > **New repository secret**.
   - Name: `CRAVE_CONF`
   - Value: Paste the entire content of your `crave.conf` file.

---

### Step 3: Start the Build
1. In your GitHub repository, click on the **Actions** tab.
2. Under "Workflows" on the left sidebar, click **Build Custom ROM (Crave.io)**.
3. Click the **Run workflow** button on the right.
4. Leave the default settings (Target: `lexus`, Manifest: `Lunaris-AOSP/android.git`, Branch: `16.2`, Command: `m bacon`).
5. Click **Run workflow**!

---

### 📦 Output
Once the build completes (usually in ~35-50 minutes on Crave's 64-core runner), the finished flashable `.zip` file will be automatically uploaded to the GitHub Actions Artifacts section for download.
