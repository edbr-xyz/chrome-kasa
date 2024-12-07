FROM python:3-alpine

# Install go-chromecast
RUN wget https://github.com/vishen/go-chromecast/releases/download/v0.3.2/go-chromecast_0.3.2_linux_arm64.tar.gz \ 
    && tar -xzf go-chromecast_0.3.2_linux_arm64.tar.gz \ 
    && install ./go-chromecast /usr/bin/ \ 
    && rm go-chromecast_0.3.2_linux_arm64.tar.gz \
    && rm -r ./go-chromecast

# Install python-kasa
RUN pip install python-kasa --break-system-packages --no-cache-dir

# Add python script
ADD src/* .

# Arguements for the python script
ENV script=chrome-kasa.py \
    chromecast=default_chromecast_value \
    plug=default_kasa_value \
    idle=60

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

CMD ["sh", "-c", "python3 -u ${script} ${chromecast// /###space###} ${plug} ${idle}"]