# Google Cloud Code Hosts Fix

A small Windows utility script to fix Google Cloud Code / Antigravity sign-in setup issues caused by incorrect local `hosts` entries.

## What does it fix?

This script removes any line in the Windows `hosts` file that contains:

```txt
cloudcode-pa.googleapis.com
```

This can help fix errors like:

```txt
There was an unexpected issue setting up your account
```

when Google Cloud Code or Antigravity cannot complete account setup because the domain is blocked or mapped incorrectly in the local `hosts` file.

## What does the script do?

The script will:

1. Request Administrator permission.
2. Open the Windows hosts file:
   ```txt
   C:\Windows\System32\drivers\etc\hosts
   ```
3. Remove lines containing:
   ```txt
   cloudcode-pa.googleapis.com
   ```
4. Flush the Windows DNS cache.
5. Check whether the hosts entry was removed successfully.

## Requirements

- Windows
- Administrator permission

## Usage

1. Download `fix-google-cloudcode.bat`.
2. Right-click the file.
3. Choose **Run as administrator**.
4. Wait for the script to finish.
5. Restart Google Cloud Code / Antigravity if needed.

## Is this tied to my IP, API key, or account?

No.

This script does not use:

- API keys
- tokens
- Google account data
- IP-specific configuration
- project IDs
- private credentials

It only modifies the local Windows `hosts` file.

## Safety note

This script only removes entries containing:

```txt
cloudcode-pa.googleapis.com
```

from the local `hosts` file. It does not install software, download files, or send data anywhere.

## Disclaimer

Use at your own risk. This tool is provided as-is for fixing local DNS/hosts configuration issues.
