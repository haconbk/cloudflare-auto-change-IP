# Thay đổi cấu hình Cloudflare tự động
Tự động thay đổi cấu hình A record cho domain trên Cloudflare khi IP của server thay đổi
## Cấu hình
*DomainName=your-domain-name.com*  
**nhập domain**  
*cloudflare_auth_email=your-email@domain.com*  
**nhập email đăng ký tài khoản Cloudflare**  
*cloudflare_auth_key=123456789qwertyuiopasdfghjklzxcvbnm00*  
**lấy "Global API Key" tài khoản Cloudflare**  
## Sử dụng
```
chmod u+x cloudflare-auto-change-ip.sh  
./cloudflare-auto-change-ip.sh
```
## Crontab chạy tự động
Thiết lập crontab để 30 phút script tự chạy một lần
```
crontab -e
```
Chèn vào nội dung sau
```
*/30 * * * * /bin/bash /link-to-file/cloudflare-auto-change-ip.sh
```
## Liên hệ
Mạnh Hà  
Email: hapm@manhha.dev  
Homepage: <https://manhha.dev>
