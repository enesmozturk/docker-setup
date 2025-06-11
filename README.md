curl -s https://raw.githubusercontent.com/enesmozturk/docker-setup/main/setup.sh | bash


🔒 Güvenlik Alternatifi: SSH ile Klonlama
Eğer token'ı URL'de yazmak istemiyorsan, SSH ile bağlanmak daha güvenli ve kalıcıdır.

SSH ile kullanım:
VPS'te SSH anahtarı oluştur:

bash
Kopyala
Düzenle
ssh-keygen -t ed25519 -C "vps"
(Enter → Enter → Enter)

Public key'i al:

bash
Kopyala
Düzenle
cat ~/.ssh/id_ed25519.pub
GitHub → Settings → SSH and GPG keys → New SSH Key → Yapıştır → Kaydet

Artık şunu kullanabilirsin:

bash
Kopyala
Düzenle
git clone git@github.com:enesmozturk/Binenso-randevu.git /opt/proje


** GitHub Token ile erişim: **

GitHub'a giriş yap: https://github.com/settings/tokens

“Fine-grained token” yerine “Classic token” seç → Generate new token (classic)

Aşağıdakileri seç:

  * repo (tam repo erişimi)

  * Süre: 30 gün (veya sana uygun başka bir süre)

Token'ı oluştur ve kopyala. (🔴 Sadece 1 kez gösterilir)

