FROM golang:1.23-alpine

# Install go-chromecast
RUN wget https://github.com/vishen/go-chromecast/releases/download/v0.3.2/go-chromecast_0.3.2_linux_arm64.tar.gz && tar -xzf go-chromecast_0.3.2_linux_arm64.tar.gz && install ./go-chromecast /usr/bin/ && rm go-chromecast_0.3.2_linux_arm64.tar.gz

# Install python and python-kasa
RUN apk add --no-cache python3 py3-pip
RUN pip install python-kasa tzdata --break-system-packages
RUN apk del py3-pip

# Add python script
ADD src/* .

# Arguements for the python script
ENV chromecast=default_chromecast_value
ENV kasa=default_kasa_value
ENV idle=60

# Don't run as root
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

# Run
CMD ["sh", "-c", "python3 -u chrome-kasa.py ${chromecast// /###space###} ${kasa} ${idle}"]