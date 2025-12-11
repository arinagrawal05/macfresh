# 🧼 macfresh

### Ultra-Safe macOS Cleanup Utility

**Version 1.0.1** • Developed by [Arin Agrawal](https://x.com/ArinBuilds)

macfresh is a **developer-friendly, ultra-safe macOS cleanup tool** that removes only junk files, never touching your applications, settings, login sessions, or development environments.

It is designed for people who want a **clean, fast Mac** without the risk of breaking anything important.

---

## ✨ Features

### 🛡 100% Safe Cleanup (Guaranteed)

macfresh **never deletes**:

* Application settings
* Browser data (cookies, logins, history)
* Docker images or containers
* Development environments (npm, pip, pyenv, etc.)
* Downloads folder
* User-created files

### 🧹 What macfresh Removes

* Old Homebrew cached downloads
* System temporary files (`*.tmp`, `*.temp`)
* User temporary files
* npm & pip caches
* QuickLook thumbnail cache
* Old logs (older than 7 days)
* Trash contents

### 📊 What macfresh Reports

* Disk usage *before* cleanup
* Disk usage *after* cleanup
* Total space reclaimed
* Detailed section-by-section cleanup
* Skipped items
* A clear summary of what was cleaned & preserved

### 🧪 Developer Safe

macfresh is built for developers:

* Does not touch `node_modules`
* Does not modify Homebrew installations
* Does not clean Docker automatically
* Does not remove useful dev files
* Never deletes anything risky

---

## 🚀 Installation

Install via Homebrew:

```bash
brew install arinagrawal05/labs/macfresh
```

Run:

```bash
macfresh
```

---

## 📘 Usage

### Full cleanup

```bash
macfresh
```

### Dry run (no changes made)

```bash
macfresh --dry-run
```

### Show version

```bash
macfresh --version
```

### Help menu

```bash
macfresh --help
```

---

## 🖥 Example Output

```
=================================================
                 🧼  macfresh
        Ultra-Safe macOS Cleanup Utility
=================================================
Version 1.0.1 — Status Report

This cleanup is designed to be 100% safe.
No application settings or development environments
are modified in any way.  ✅ Guaranteed Safe

-------------------------------------------------
📊  Disk Usage — Before Cleanup
-------------------------------------------------
Used: 11Gi
Free: 20Gi
Usage: 37%

-------------------------------------------------
📦  Homebrew Cleanup (Safe)
-------------------------------------------------
Removing old cached downloads…
(Installed packages are never touched)  ✅ Safe
...
```

---

## 🧪 Development

Clone the repository:

```bash
git clone https://github.com/arinagrawal05/macfresh
cd macfresh
chmod +x macfresh.sh
./macfresh.sh
```

Test flags:

```bash
./macfresh.sh --dry-run
./macfresh.sh --help
```

---

## 📦 Release Process

1. Update `VERSION` inside `macfresh.sh`
2. Commit changes
3. Create a GitHub Release and upload `macfresh.sh`
4. Generate SHA256
5. Update `macfresh.rb` in the `homebrew-labs` tap
6. Push the updated formula

Users then upgrade using:

```bash
brew upgrade macfresh
```

---

## 🤝 Contributing

Contributions and feature requests are welcome.
If you’d like to improve macfresh, open an issue or PR.

---

## 🧑‍💻 Author

**Arin Agrawal**

* Twitter: [https://x.com/ArinBuilds](https://x.com/ArinBuilds)
* GitHub: [https://github.com/arinagrawal05](https://github.com/arinagrawal05)

---

## 📄 License

MIT License
