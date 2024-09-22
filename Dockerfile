FROM ghcr.io/open-webui/open-webui:main

# Install dependencies and ZeroTier
RUN apt-get update && \
    apt-get install -y --no-install-recommends wget gnupg openssl curl supervisor && \
    curl -s https://install.zerotier.com | bash && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Ensure the `zerotier-one` data directory exists
RUN mkdir -p /var/lib/zerotier-one && \
    chown root:root /var/lib/zerotier-one && \
    echo "9993" > /var/lib/zerotier-one/zerotier-one.port

# Copy the zerotier-init script and make it executable
COPY zerotier-init.sh /zerotier-init.sh
RUN chmod +x /zerotier-init.sh
