FROM ubuntu

RUN apt-get update && apt-get install -y wget
RUN wget https://downloads.robocorp.com/rcc/releases/v13.7.1/linux64/rcc && wget https://downloads.robocorp.com/rcc/releases/v13.7.1/linux64/rccremote
RUN chmod +x rcc rccremote && mv rcc rccremote /usr/bin