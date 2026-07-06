<div align="center">

# ✨ Google Cloud Code Hosts Fix ✨

### 🛠️ One-click Windows helper for Google Cloud Code / Antigravity sign-in setup issues

<p>
  <img alt="Windows" src="https://img.shields.io/badge/Windows-0078D4?style=for-the-badge&logo=windows&logoColor=white">
  <img alt="Batch" src="https://img.shields.io/badge/Batch_Script-4D4D4D?style=for-the-badge&logo=gnubash&logoColor=white">
  <img alt="License" src="https://img.shields.io/badge/License-MIT-22c55e?style=for-the-badge">
</p>

> Clean local `hosts` entries, flush DNS, and get Cloud Code sign-in working again.

</div>

---

## 🚀 What is this?

This is a tiny Windows utility script that fixes Google Cloud Code / Antigravity account setup issues caused by incorrect local `hosts` entries.

It is useful when you see an error like:

```txt
There was an unexpected issue setting up your account
```

## 🎯 What does it fix?

The script removes any line in the Windows `hosts` file that contains:

```txt
cloudcode-pa.googleapis.com
```

If this domain is blocked or mapped to a wrong IP, Google Cloud Code / Antigravity may fail during account setup.

---

## ✨ Features

- 🛡️ Automatically requests Administrator permission
- 🧹 Removes broken `cloudcode-pa.googleapis.com` hosts entries
- ⚡ Flushes Windows DNS cache
- ✅ Checks whether the fix was applied successfully
- 🔒 No API keys, tokens, accounts, or private data required
- 🌈 Colorful console output for easier reading

---

## 📦 Download

Download the script from this repository:

```txt
fix-google-cloudcode.bat
```

Or clone the repo:

```bash
git clone https://github.com/ltntai/google-cloudcode-hosts-fix.git
```

---

## 🧭 Usage

1. Download `fix-google-cloudcode.bat`.
2. Right-click the file.
3. Choose **Run as administrator**.
4. Wait for the script to finish.
5. Restart Google Cloud Code / Antigravity if needed.

---

## 🧩 What does the script do?

| Step | Action |
| --- | --- |
| 1 | Requests Administrator permission |
| 2 | Opens `C:\Windows\System32\drivers\etc\hosts` |
| 3 | Removes entries containing `cloudcode-pa.googleapis.com` |
| 4 | Runs `ipconfig /flushdns` |
| 5 | Verifies that the hosts entry is gone |

---

## 🔐 Is this tied to my IP, API key, or account?

**No.**

This script does **not** use:

- ❌ API keys
- ❌ tokens
- ❌ Google account data
- ❌ IP-specific configuration
- ❌ project IDs
- ❌ private credentials

It only modifies your local Windows `hosts` file.

---

## 🪟 Requirements

- Windows
- Administrator permission

---

## 🛡️ Safety note

This script only removes entries containing:

```txt
cloudcode-pa.googleapis.com
```

from the local `hosts` file.

It does **not** install software, download files, or send data anywhere.

---

## ⚠️ Disclaimer

Use at your own risk. This tool is provided as-is for fixing local DNS / hosts configuration issues.

---

<div align="center">

Made with 💙 by [Tấn Tài](https://github.com/ltntai)

</div>
