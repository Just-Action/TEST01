# This script runs before SSH in Ubuntu instances

#Delete some files
sudo rm -rf /usr/local/lib/android
sudo rm -rf /usr/local/.ghcup
sudo rm -rf /opt/hostedtoolcache/CodeQL
sudo rm -rf /usr/share/dotnet

# Add ssh private key
sudo su
mkdir -p ~/.ssh/
echo "$SSH_PRIVATE_KEY" > ~/.ssh/id_rsa
chmod 700 ~/.ssh
chmod 600 ~/.ssh/id_rsa
ssh-keyscan github.com >> ~/.ssh/known_hosts
ssh-keyscan gitlab.com >> ~/.ssh/known_hosts
ssh-keyscan gitee.com >> ~/.ssh/known_hosts
exit

# Setting the time zone
# sudo timedatectl set-timezone "Asia/Shanghai"

# Install the tools you need to use
sudo apt update
# sudo chsh -s /bin/zsh
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install VsCode
sudo mkdir -p /root/vscode
sudo curl -Lk 'https://code.visualstudio.com/sha/download?build=stable&os=cli-alpine-x64' --output /root/vscode/vscode_cli.tar.gz
sudo tar -xf /root/vscode/vscode_cli.tar.gz -C /root/vscode/
# sudo screen -S vscode bash -c "cd /root/vscode && ./code tunnel"

# Install Nginx
sudo apt install curl gnupg2 ca-certificates lsb-release ubuntu-keyring -y
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
    | sudo tee /etc/apt/sources.list.d/nginx.list
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
    | sudo tee /etc/apt/preferences.d/99nginx
# sudo apt update
# sudo apt install nginx -y

sudo apt install -y neofetch tmux

wget https://github.com/bootandy/dust/releases/download/v0.8.6/du-dust_0.8.6_amd64.deb
sudo dpkg -i du-dust_0.8.6_amd64.deb
rm du-dust_0.8.6_amd64.deb
