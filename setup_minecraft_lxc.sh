#!/bin/bash

# Minecraft Server Installer for LXC Containers on Proxmox
# Tested on Debian 11/12
# Author: TimInTech

# Update & Install Dependencies
apt update && apt upgrade -y
apt install -y openjdk-17-jre-headless screen wget curl

# Create Minecraft Server Directory
mkdir -p /opt/minecraft && cd /opt/minecraft

# Download Minecraft Server
wget -O server.jar https://api.papermc.io/v2/projects/paper/versions/1.21.4/builds/207/downloads/paper-1.21.4-207.jar

# Accept EULA
echo "eula=true" > eula.txt

# Create a Start Script
cat <<EOF > start.sh
#!/bin/bash
java -Xms2G -Xmx4G -jar server.jar nogui
EOF

chmod +x start.sh

# Start Server in Screen Session
screen -dmS minecraft ./start.sh

echo "✅ Minecraft Server setup completed! Use 'screen -r minecraft' to access the console."
