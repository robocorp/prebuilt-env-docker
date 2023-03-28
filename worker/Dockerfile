FROM robocorp/rccremote

# Set all variables that affect programs to follow same encoding
ENV LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8
ENV OPENSSL_CONF=/dev/null

# Install here all the software your process needs in order to execute
RUN apt-get update --fix-missing && \
    apt-get install -y curl bash zip && \
    apt-get install -y fonts-indic fonts-noto fonts-noto-cjk

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

# initialize the Agent Core
RUN /home/worker/bin/robocorp-workforce-agent-core init --log-level TRACE --rcc-exec-path /home/worker/bin/rcc