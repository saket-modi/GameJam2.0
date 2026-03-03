# Steps to setup the test code

---

## Step 1: Download and Install Git

### 🔹 Windows
1. Go to: https://git-scm.com/download/win
2. Download the installer.
3. Run the installer.
4. Keep default settings and click **Next** until installation completes.
5. Verify installation:
   ```bash
   git --version
   ```

### 🔹 macOS
1. Open Terminal.
2. Install using Homebrew:
   ```bash
   brew install git
   ```
   OR download from:
   https://git-scm.com/download/mac
3. Verify:
   ```bash
   git --version
   ```

### 🔹 Linux (Ubuntu/Debian)
```bash
sudo apt update
sudo apt install git
git --version
```

---

## Step 2: Configure Git (First Time Setup)

```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

Check configuration:
```bash
git config --list
```

---

## Step 3: Create a New Folder

Navigate to the location where you want your project:

```bash
cd path/to/your/location
```

Create a new folder:

```bash
mkdir my-project
cd my-project
```

---

## Step 4: Initialize Git in the Folder

```bash
git init
```

---

## Step 5: Add a Remote Repository

Add the remote repository URL:

```bash
git remote add origin https://github.com/saket-modi/GameJam2.0.git
```

Check if remote was added:

```bash
git remote -v
```

---

## Step 6: Pull Code from Remote Repository

```bash
git pull origin main
```

> Replace `main` with `master` if the repository uses `master` branch.

---

## Alternative (Easier Method)

Instead of creating a folder manually, you can directly clone the repository:

```bash
git clone https://github.com/username/repository.git
```

This automatically:
- Creates the folder
- Initializes Git
- Adds the remote
- Pulls the code

---

## ✅ Done!

Your remote repository code should now be inside your local folder.