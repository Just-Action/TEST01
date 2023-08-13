# This script runs before SSH in Ubuntu instances

## Example ##

#Delete some files
sudo rm -rf /usr/local/lib/android
sudo rm -rf /usr/local/.ghcup
sudo rm -rf /opt/hostedtoolcache/CodeQL
sudo rm -rf /usr/share/dotnet

# Setting the time zone
sudo timedatectl set-timezone "Asia/Shanghai"

# Install the tools you need to use
sudo apt update
sudo apt install -y neofetch
sudo apt install curl gnupg2 ca-certificates lsb-release ubuntu-keyring
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list

echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
    | sudo tee /etc/apt/preferences.d/99nginx

sudo apt update
sudo apt install nginx -y

wget https://github.com/bootandy/dust/releases/download/v0.8.6/du-dust_0.8.6_amd64.deb
sudo dpkg -i du-dust_0.8.6_amd64.deb
rm du-dust_0.8.6_amd64.deb
