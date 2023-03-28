FROM --platform=amd64 ubuntu

ENV LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8
ENV OPENSSL_CONF=/dev/null

RUN apt-get update && apt-get install -y wget curl
RUN wget https://downloads.robocorp.com/rcc/releases/v13.9.1/linux64/rcc && wget https://downloads.robocorp.com/rcc/releases/v13.9.1/linux64/rccremote
RUN chmod +x rcc rccremote && mv rcc rccremote /usr/bin

RUN apt-get update && \
    apt-get install -y openssl && \
    openssl genrsa -des3 -passout pass:x -out server.pass.key 2048 && \
    openssl rsa -passin pass:x -in server.pass.key -out server.key && \
    rm server.pass.key && \
    openssl req -new -key server.key -out server.csr \
        -subj "/C=US/ST=State/L=Location/O=Robocorp/OU=RPA Dep/CN=example.com" && \
    openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

# shared HT are required
RUN /usr/bin/rcc ht shared -e && /usr/bin/rcc ht init

WORKDIR /home/worker

# Create the agent inside the image
RUN mkdir -p /home/worker/bin && \
    mkdir -p /home/worker/.robocorp \
    mkdir -p /home/worker/bin/conda && \
    mkdir -p /home/worker/instance
RUN curl --silent --show-error --fail -o /home/worker/bin/robocorp-workforce-agent-core https://downloads.robocorp.com/workforce-agent-core/releases/latest/linux64/robocorp-workforce-agent-core
RUN chmod +x /home/worker/bin/robocorp-workforce-agent-core
RUN /home/worker/bin/robocorp-workforce-agent-core init --log-level TRACE --rcc-exec-path /home/worker/bin/rcc

COPY start.sh .
CMD "./start.sh"