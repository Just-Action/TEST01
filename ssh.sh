#!/usr/bin/env bash
Green_font_prefix="\033[32m"
Red_font_prefix="\033[31m"
Green_background_prefix="\033[42;37m"
Red_background_prefix="\033[41;37m"
Font_color_suffix="\033[0m"
INFO="[${Green_font_prefix}INFO${Font_color_suffix}]"
ERROR="[${Red_font_prefix}ERROR${Font_color_suffix}]"

# LOG_FILE='/tmp/sshtest.log'
CONTINUE_FILE="/tmp/continue"

# 检测 Cloudflred Tunnel Token
if [[ -z "${CLOUDFLARED_TOKEN}" ]]; then
    echo -e "${ERROR} Please set 'CLOUDFLARED_TOKEN' environment variable."
    exit 1
fi

# 检测 SSH 密码
if [[ -z "${SSH_PASSWORD}" && -z "${SSH_PUBKEY}" && -z "${GH_SSH_PUBKEY}" ]]; then
    echo -e "${ERROR} Please set 'SSH_PASSWORD' environment variable."
    exit 2
fi

# 设置密码
if [[ -n "${SSH_PASSWORD}" ]]; then
    echo -e "${INFO} Set user(${USER}) password ..."
    echo -e "${SSH_PASSWORD}\n${SSH_PASSWORD}" | sudo passwd "${USER}"
fi

# 开始安装
echo -e "${INFO} Start install cloudflared..."
curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && 
sudo dpkg -i cloudflared.deb && 
# sudo cloudflared service install eyJhIjoiMTI0NmMxNDY4MGVhMjgzYzliMDE3MjQwMDI5NjFiNjQiLCJ0IjoiNzA4MjFiZGUtMDJiOS00NDUyLWFjMjMtN2I5YmI2MDk1MzVhIiwicyI6Ik1UTmpNR1UxTVRJdFlXWmpNUzAwWm1ZMExUazFPVGt0WmpnNU5EVXpOakJqTkRRMyJ9
${CLOUDFLARED_TOKEN}

# 输出TIPS提示信息
echo -e "🔔 *TIPS:*\nRun '\`touch ${CONTINUE_FILE}\`' to continue to the next step.\n"

while [[ -n $(ps aux | grep cloudflared) ]]; do
    sleep 1
    if [[ -e ${CONTINUE_FILE} ]]; then
        echo -e "${INFO} Continue to the next step."
        exit 0
    fi
done
