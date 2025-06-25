##1. rclone Kurulumu (Ubuntu)
sudo apt update
sudo apt install -y rclone
##2. Google Drive Hesabı Aç & Hazırla
##Gmail hesabınla drive.google.com’a gir. 15GB alan veriyor.

##(Tercihen) yeni bir “Binenso Backups” klasörü aç.

rclone config

#######
##Gelen ekranda:
##
##n → Yeni remote ekle
##
##Name: gdrive (veya istediğin isim)
##
##Storage: google drive yaz, çıkanlardan seç
##
##Client ID/Secret: Boş geçebilirsin (Enter)
##
##Scope: 1 (Full access) yaz
##
##Root Folder ID: Boş bırak (Enter)
##
##Service Account: No
##
##Advanced config: No
##
##Use auto config: No (Eğer ssh ile bağlandığın VPS’te ekran yoksa bu önemli)
##
##Şimdi sana bir URL verecek.
##Bu linki kendi bilgisayarında tarayıcıda açıp, Google hesabınla giriş yapıp izin ver.
##Sonrasında çıkan authorization code’u VPS konsoluna yapıştır.
##
##Hepsi bu!
##Yazdıklarını özetlemiş hali:

#n
#gdrive
#drive
#(enter)
#(enter)
#1
#(enter)
#n
#n
#n
#(url → local tarayıcıda aç, kodu yapıştır)

rclone lsd gdrive:


##5. Yedekleme Scripti (PostgreSQL için örnek)
#Aşağıdaki bash scriptiyle db yedeğini alıp Drive’a upload edebilirsin:
/opt/scripts/pg_backup_to_gdrive.sh

#!/bin/bash
DATE=$(date +%F-%H%M)
BACKUP_NAME="pg_backup_$DATE.sql.gz"
DB_NAME="veritabani_adi"
DB_USER="postgres"
# İstersen buraya export PGPASSWORD=xxx ekle (ya da .pgpass kullan)

# Dump al
pg_dump -U $DB_USER $DB_NAME | gzip > /tmp/$BACKUP_NAME

# Google Drive’a kopyala (gdrive:/binenso-backups dizini varsa oraya)
rclone copy /tmp/$BACKUP_NAME gdrive:binenso-backups/

# Yerelden sil
rm /tmp/$BACKUP_NAME


6. Otomatikleştirme (crontab)
crontab -e komutunu çalıştır, aşağıdaki satırı ekle:

0 3 * * * /opt/scripts/pg_backup_to_gdrive.sh >> /var/log/pg_backup.log 2>&1



7. Ek Güvenlik (İsteğe Bağlı)
Dosyayı şifrelemek istersen:

bash
Kopyala
Düzenle
gpg --symmetric --cipher-algo AES256 /tmp/$BACKUP_NAME
rclone copy /tmp/$BACKUP_NAME.gpg gdrive:binenso-backups/
rm /tmp/$BACKUP_NAME.gpg
Eski yedekleri silmek için:

bash
Kopyala
Düzenle
rclone delete --min-age 30d gdrive:binenso-backups/
(30 günden eski dosyaları Drive’dan siler.)