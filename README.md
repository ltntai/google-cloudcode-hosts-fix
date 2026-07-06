<div align="center">

# ✨ Google Cloud Code Hosts Fix ✨

### 🛠️ Fix Antigravity / Google Cloud Code sign-in error on Windows

<p>
  <img alt="Windows" src="https://img.shields.io/badge/Windows-0078D4?style=for-the-badge&logo=windows&logoColor=white">
  <img alt="Google Cloud Code" src="https://img.shields.io/badge/Google_Cloud_Code-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white">
  <img alt="Antigravity" src="https://img.shields.io/badge/Antigravity-7c3aed?style=for-the-badge&logo=googlegemini&logoColor=white">
  <img alt="Batch" src="https://img.shields.io/badge/Batch_Script-4D4D4D?style=for-the-badge&logo=gnubash&logoColor=white">
  <img alt="License" src="https://img.shields.io/badge/License-MIT-22c55e?style=for-the-badge">
</p>

> Windows `.bat` tool to fix `There was an unexpected issue setting up your account` by cleaning broken Google Cloud Code hosts entries and flushing DNS.

</div>

---

## 🚀 What is this?

**Google Cloud Code Hosts Fix** is a small Windows batch script for fixing **Antigravity sign-in**, **Google Cloud Code account setup**, and **9Router routing** issues caused by stale or incorrect local `hosts` entries.

It is especially useful for cases where Antigravity shows this error while being routed through tools such as **9Router**:

```txt
There was an unexpected issue setting up your account
```

## 🎯 What does it fix?

The script removes any line in the Windows `hosts` file that contains:

```txt
cloudcode-pa.googleapis.com
```

If this domain is blocked or mapped to a wrong IP, Google Cloud Code / Antigravity may fail during account setup. This can happen after local routing, proxy, or MITM-style debugging setups leave a stale hosts entry behind.

---

## ✨ Features

- 🛡️ Automatically requests Administrator permission
- 🧹 Removes broken `cloudcode-pa.googleapis.com` hosts entries
- ⚡ Flushes Windows DNS cache
- ✅ Checks whether the fix was applied successfully
- 🔒 No API keys, tokens, accounts, or private data required
- 🌈 Colorful console output for easier reading

---

## 🔎 Search keywords

This project may help if you are searching for:

- `Antigravity there was an unexpected issue setting up your account`
- `Google Cloud Code sign in error Windows`
- `Google Cloud Code account setup error`
- `cloudcode-pa.googleapis.com hosts file fix`
- `9Router Antigravity setup issue`
- `Windows hosts file DNS fix for Google Cloud Code`

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
