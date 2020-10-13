
# Based on wiorca/docker-windscribe
FROM wiorca/docker-windscribe:latest

# Version
ARG VERSION=0.0.3

# Expose the webadmin port for qBittorrent
EXPOSE 8080/tcp

# Create a volume for the bittorrent data
VOLUME [ "/data" ]

# Update ubuntu container, and install the basics, Add windscribe ppa, Install windscribe, and some to be removed utilities
RUN apt -y update && apt install -y qbittorrent-nox && \
    apt -y autoremove && apt -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add in scripts for health check and start-up
ADD app-health-check.sh /opt/scripts/app-health-check.sh
ADD app-startup.sh /opt/scripts/app-startup.sh
ADD app-setup.sh /opt/scripts/app-setup.sh

