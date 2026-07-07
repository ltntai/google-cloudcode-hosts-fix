<div align="center">

# ✨ Google Cloud Code Hosts Fix

### Route Antigravity / Google Cloud Code through local 9Router on Windows

<p>
  <img alt="Windows" src="https://img.shields.io/badge/Windows-0078D4?style=for-the-badge&logo=windows&logoColor=white">
  <img alt="Google Cloud Code" src="https://img.shields.io/badge/Google_Cloud_Code-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white">
  <img alt="Antigravity" src="https://img.shields.io/badge/Antigravity-7c3aed?style=for-the-badge&logo=googlegemini&logoColor=white">
  <img alt="9Router" src="https://img.shields.io/badge/9Router-localhost-111827?style=for-the-badge">
  <img alt="Batch" src="https://img.shields.io/badge/Batch_Script-4D4D4D?style=for-the-badge&logo=gnubash&logoColor=white">
  <img alt="License" src="https://img.shields.io/badge/License-MIT-22c55e?style=for-the-badge">
</p>

**A small Windows helper for fixing Antigravity / Google Cloud Code sign-in or account setup issues when using local 9Router routing.**

</div>

---

## 🚀 What is this?

**Google Cloud Code Hosts Fix** is a lightweight Windows batch-script toolkit that routes Google Cloud Code traffic used by **Antigravity IDE** through a local **9Router** listener.

It helps when Antigravity / Google Cloud Code shows errors like:

```txt
There was an unexpected issue setting up your account
```

or when Cloud Code traffic is not being routed through 9Router because the Windows `hosts` file is missing the required localhost mappings.

---

## 🎯 What does it do?

The main script updates:

```txt
C:\Windows\System32\drivers\etc\hosts
```

It removes old entries for these Cloud Code domains and then writes clean localhost routes:

```txt
127.0.0.1 cloudcode-pa.googleapis.com
127.0.0.1 daily-cloudcode-pa.googleapis.com
::1 cloudcode-pa.googleapis.com
::1 daily-cloudcode-pa.googleapis.com
```

After that, it flushes the Windows DNS cache and verifies that all required routes exist.

> [!IMPORTANT]
> 9Router should be running locally before you open Antigravity. The script checks whether port `443` has a local listener and warns you if it does not.

---

## ✨ Features

- 🛡️ Requests Administrator permission automatically when needed
- 🧹 Removes stale Cloud Code hosts entries before writing new ones
- 🔁 Adds both `cloudcode-pa.googleapis.com` and `daily-cloudcode-pa.googleapis.com`
- 🌐 Supports IPv4 `127.0.0.1` and IPv6 `::1`
- ⚡ Flushes Windows DNS cache
- ✅ Verifies all required routes after writing
- 🚀 Includes a launcher that restarts Antigravity after applying the route
- ⏰ Optional Windows logon autorun through Task Scheduler
- 🔒 No API keys, tokens, Google accounts, or private credentials required

---

## 📁 Files

| File | Purpose |
| --- | --- |
| `fix-google-cloudcode.bat` | Main script. Applies localhost routes and flushes DNS. |
| `start-antigravity-9router.bat` | Closes Antigravity, applies the route, checks port `443`, then starts Antigravity again. |
| `setup-autorun.bat` | Enables or disables a Windows Scheduled Task that applies the route on login. |
| `.vscode/tasks.json` | Optional VS Code task that can run the fix on folder open. |
| `LICENSE` | MIT license. |

---

## 🧭 Usage

### Option 1: Apply the route manually

1. Start 9Router.
2. Right-click `fix-google-cloudcode.bat`.
3. Choose **Run as administrator**.
4. Wait for the hosts update, DNS flush, and verification to finish.
5. Fully close and reopen Antigravity if needed.

### Option 2: Start Antigravity with the 9Router route

Use this if you want the full flow in one click:

```txt
start-antigravity-9router.bat
```

It will:

1. Request Administrator permission.
2. Close Antigravity and its language server process.
3. Run `fix-google-cloudcode.bat /silent`.
4. Check whether a local HTTPS listener exists on port `443`.
5. Start Antigravity again.

### Option 3: Run automatically on Windows login

Use this if you want the route to be applied every time you sign in:

1. Right-click `setup-autorun.bat`.
2. Choose **Run as administrator**.
3. Press `1` to enable autorun.
4. A Scheduled Task named `FixGoogleCloudCodeHosts` will be created.
5. The task runs about 20 seconds after Windows login.

To disable autorun, run `setup-autorun.bat` again and press `2`.

---

## 🧩 How the main script works

| Step | Action |
| --- | --- |
| 1 | Checks Administrator permission |
| 2 | Warns if no local listener is found on port `443` |
| 3 | Reads the Windows `hosts` file |
| 4 | Removes old entries for the target Cloud Code domains |
| 5 | Adds fresh IPv4 and IPv6 localhost routes |
| 6 | Runs `ipconfig /flushdns` |
| 7 | Verifies that all required routes are present |

---

## 🔎 Search keywords

This project may help if you are searching for:

- `Antigravity there was an unexpected issue setting up your account`
- `Google Cloud Code sign in error Windows`
- `Google Cloud Code account setup error`
- `Google Cloud Code 9Router fix`
- `cloudcode-pa.googleapis.com hosts file`
- `daily-cloudcode-pa.googleapis.com hosts file`
- `Windows hosts file DNS fix`
- `9Router Antigravity setup issue`

---

## 🔐 Privacy and safety

This project does **not** use or collect:

- ❌ API keys
- ❌ tokens
- ❌ Google account data
- ❌ project IDs
- ❌ private credentials
- ❌ network upload/download logic

It only modifies selected lines in your local Windows `hosts` file and flushes the local DNS cache.

> [!WARNING]
> This tool intentionally changes DNS resolution for the listed Google Cloud Code domains on your machine. Only use it if you understand that those domains will point to your local 9Router listener.

---

## 🪟 Requirements

- Windows
- Administrator permission
- Local 9Router listener, usually on port `443`
- Antigravity IDE / Google Cloud Code

---

## ⚠️ Disclaimer

Use at your own risk. This tool is provided as-is for local DNS / hosts configuration when routing Antigravity or Google Cloud Code through 9Router.

---

<div align="center">

Made with 💙 by [Tấn Tài](https://github.com/ltntai)

</div>
