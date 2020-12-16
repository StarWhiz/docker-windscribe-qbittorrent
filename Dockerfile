
# Based on wiorca/docker-windscribe
FROM wiorca/docker-windscribe:latest

# Version
ARG VERSION=0.0.3

# Expose the webadmin port for qBittorrent
EXPOSE 8080/tcp

# Create a volume for the bittorrent data
VOLUME [ "/data" ]

# Add qbitorrent ppa, update ubuntu container, and install the basics, Add windscribe ppa, Install windscribe, and some to be removed utilities
RUN echo "deb http://ppa.launchpad.net/qbittorrent-team/qbittorrent-stable/ubuntu focal main" | tee -a /etc/apt/sources.list && \
    echo "deb-src http://ppa.launchpad.net/qbittorrent-team/qbittorrent-stable/ubuntu focal main" | tee -a /etc/apt/sources.list && \
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 401E8827DA4E93E44C7D01E6D35164147CA69FC4 && \
    apt -y update && apt install -y qbittorrent-nox && \
    apt -y autoremove && apt -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add in scripts for health check and start-up
ADD app-health-check.sh /opt/scripts/app-health-check.sh
ADD app-startup.sh /opt/scripts/app-startup.sh
ADD app-setup.sh /opt/scripts/app-setup.sh

