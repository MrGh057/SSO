#!/bin/bash

# Actualizaciones de paquetería.
echo -e "\t [!] Actualizando paquetes..."
sudo apt-get update >> /var/log/hardening.log
sudo apt-get upgrade -y >> /var/log/hardening.log
echo -e "\t [+] Se actualizaron los paquetes con éxito." >> /var/log/hardening.log


# Políticas de contraseñas.
echo -e "\t [!] Setting password policies..."
sudo sed -i 's/PASS_MAX_DAYS\t99999/PASS_MAX_DAYS\t90/' /etc/login.defs
sudo authconfig --passalgo=sha512 --update >> /var/log/hardening.log
echo -e "\t [+] Políticas de contraseñas implementadas" >> /var/log/hardening.log
# Configuración PAM
echo -e "\t [!] Configurando PAM..."
sudo sed -i 's/password\t\t\[success=1 default=ignore\]\tpam_unix\.so obscure sha512/password\t\t[success=1 default=ignore]\tpam_unix.so obscure sha512 minlen=8 retry=1/' /etc/pam.d/common-password
echo -e "\t [+] PAM Configurado correctamente." >> /var/log/hardening.log
# Configuración de sudoers
echo -e "\t [!] Configurando sudoers..."
echo "$USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USER > /dev/null
echo -e "\t [+] Sudoers configurado correctamente." >> /var/log/hardening.log
# Banner de inicio de sesión
echo -e "\t [!] Configurando banner de inicio de sesión..."
sudo touch /etc/motd
sudo bash -c 'echo "############################" > /etc/motd'
sudo bash -c 'echo "This belongs to $1" >> /etc/motd'
sudo bash -c 'echo "All activities are being monitored" >> /etc/motd'
sudo bash -c 'echo "By $2 and unauthorized" >> /etc/motd'
sudo bash -c 'echo "changes will be prosecuted." >> /etc/motd'
sudo bash -c 'echo "############################" >> /etc/motd'
echo -e "\t [+] Banner de incio de sesión configurado." >> /var/log/hardening.log
#Configuración default de permisos para archivos y propietarios
echo -e "\t [!] Configurando permisos de archivos y propietarios"
sudo touch /etc/profile.d/umask.sh
sudo bash -c 'echo "umask 077" > /etc/profile.d/umask.sh'
sudo chmod +x /etc/profile.d/umask.sh
echo -e "\t [+] Configuraciones establecidas correctamente." >> /var/log/hardening.log


# Configuración de firewall
echo -e "\t [!] Configuracion de firewall..."
sudo ufw default deny incoming >> /var/log/hardening.log
sudo ufw default allow outgoing >> /var/log/hardening.log
sudo ufw enable >> /var/log/hardening.log
echo -e "\t [+] Configuración de firewall completada." >> /var/log/hardening.log
# Deshabilitar SELinux
echo -e "\t [!] Deshabilitando SELinux "
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
echo -e "\t [+] SELinux deshabilitado." >> /var/log/hardening.log
# Instalando antivirus
echo -e "\t [!] Instalando ClamAV antivirus..."
sudo apt-get install clamav -y >> /var/log/hardening.log
echo -e "\t [+] Se instaló ClamAV antivirus." >> /var/log/hardening.log


# Habilitar TCP SYN Cookie Protection
echo 1 > /proc/sys/net/ipv4/tcp_syncookies
echo -e "\t [+] Se habilitó TCP SYN Cookie Protection." >> /var/log/hardening.log
# Habilitar IP Spoofing Protection
echo 1 > /proc/sys/net/ipv4/conf/all/rp_filter
echo -e "\t [+] Se habilitó IP Spoofing Protection." >> /var/log/hardening.log
# Ignorar las solicitudes ICMP
echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all
echo -e "\t [+] Se configuró para ignorar las solicitudes ICMP." >> /var/log/hardening.log


# Configurar SSH para bloquear el inicio de sesión directo como root
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
echo -e "\t [+] Se bloqueó el inicio de sesión directo como root." >> /var/log/hardening.log

# Habilitar StrictMode
echo -e "\t [!] Configurando SSH..." >> /var/log/hardening.log
echo "StrictModes yes" >> /etc/ssh/sshd_config
echo -e "\t [+] Se habilitó StricMode." >> /var/log/hardening.log
# Establecer LogLevel a INFO
echo "LogLevel INFO" >> /etc/ssh/sshd_config
echo -e "\t [+] Se estableció LogLevel a INFO." >> /var/log/hardening.log
systemctl restart sshd
echo -e "\t [+] Se reinció el servicio SSH." >> /var/log/hardening.log
echo -e "\t [+] Se terminó de configurar SSH." >> /var/log/hardening.log

# Configurar SSH
#echo "[!] Configurando SSH..."
#sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config
#sudo sed -i 's/#StrictModes yes/StrictModes
