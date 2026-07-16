<div align="center">

# 🛠️ Fix Google Cloud Code

### Sửa lỗi đăng nhập Google Cloud Code / Antigravity trên Windows

<p>
  <img alt="Windows" src="https://img.shields.io/badge/Windows-0078D4?style=for-the-badge&logo=windows&logoColor=white">
  <img alt="Google Cloud Code" src="https://img.shields.io/badge/Google_Cloud_Code-4285F4?style=for-the-badge&logo=googlecloud&logoColor=white">
  <img alt="Batch" src="https://img.shields.io/badge/Single_File_Batch-4D4D4D?style=for-the-badge&logo=gnubash&logoColor=white">
  <img alt="License" src="https://img.shields.io/badge/License-MIT-22c55e?style=for-the-badge">
</p>

**Một file `.bat` duy nhất, không cài đặt, không chạy nền — chỉ cần double-click là xong.**

</div>

---

## ❓ Lỗi là gì (What's the problem)

Khi dùng Google Cloud Code / Antigravity, đôi khi bạn gặp lỗi **sign-in thất bại** hoặc **không thể xác thực tài khoản Google**. Nguyên nhân thường là do file `hosts` của Windows bị thêm một dòng trỏ domain `cloudcode-pa.googleapis.com` về một IP sai/local, khiến trình duyệt không thể bắt tay TLS với máy chủ thật của Google.

> Lỗi tiếng Anh thường gặp:
> - `Could not authenticate` / `Sign-in failed`
> - `net::ERR_CERT_AUTHORITY_INVALID` đối với `cloudcode-pa.googleapis.com`
> - `The connection was reset` khi gọi API Google

---

## 🧰 Cách hoạt động

File `fix-google-cloudcode.bat` sẽ:

1. **Tự động xin quyền Admin** (nếu chưa có) — vì sửa file `hosts` cần quyền Administrator.
2. **Xóa dòng `cloudcode-pa.googleapis.com`** khỏi file `hosts` (`C:\Windows\System32\drivers\etc\hosts`).
3. **Flush DNS** (`ipconfig /flushdns`) để xóa cache tên miền cũ.
4. **Kiểm tra kết quả** — báo `[OK]` nếu đã sạch, hoặc `[LOI]` nếu vẫn còn dòng cũ.

> [!NOTE]
> Script chỉ xóa đúng những dòng khớp với `cloudcode-pa.googleapis.com`, hoàn toàn không đụng tới các dòng hosts khác (Docker, localhost, ...).

---

## 📦 Cấu trúc repo

| File | Vai trò |
| --- | --- |
| `fix-google-cloudcode.bat` | **Toàn bộ tool** — chạy xong là sửa xong, không để lại process nào. |
| `README.md` | File hướng dẫn này. |
| `LICENSE` | MIT. |
| `.gitignore` | Bỏ qua file rác khi commit. |

---

## 🚀 Cách dùng

1. Tải file `fix-google-cloudcode.bat` về máy.
2. **Chuột phải → Run as administrator** (hoặc double-click, script sẽ tự xin quyền Admin).
3. Đợi chạy xong, thấy dòng `[OK] Hosts sach!` là thành công.
4. Mở lại Google Cloud Code / Antigravity và thử đăng nhập lại.

> [!TIP]
> Nếu vẫn lỗi sau khi chạy, hãy thử khởi động lại trình duyệt, hoặc kiểm tra thêm phần mềm VPN / proxy khác có đang chặn `googleapis.com` hay không.

---

## 🪟 Yêu cầu

- Windows (có quyền Administrator)
- Google Cloud Code / Antigravity IDE

---

Made with 💙 by [Tấn Tài](https://github.com/ltntai)
