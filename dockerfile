FROM golang:1.23-alpine
# Install go-chromecast
RUN wget https://github.com/vishen/go-chromecast/releases/download/v0.3.2/go-chromecast_0.3.2_linux_arm64.tar.gz && tar -xzf go-chromecast_0.3.2_linux_arm64.tar.gz && install ./go-chromecast /usr/bin/ && rm go-chromecast_0.3.2_linux_arm64.tar.gz

RUN apk add --no-cache python3 py3-pip

RUN pip install python-kasa tzdata --break-system-packages

RUN apk del py3-pip

ADD src/* .

ENV chromecast=default_chromecast_value
ENV kasa=default_kasa_value

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

CMD ["sh", "-c", "python3 -u kasa-chromecast.py ${chromecast// /###space###} ${kasa}"]