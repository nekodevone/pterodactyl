FROM mono:6
ENV USER=container HOME=/home/container

# Install prerequisites
RUN dpkg --add-architecture i386 \
  && apt-get update \
  && apt-get install -y lib32gcc1

# Create user
RUN adduser --disabled-password $USER \
  && chown -R $USER:$USER $HOME

# Prepare container
USER $USER
WORKDIR $HOME

# Install SteamCMD
RUN curl -sqL "https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz" | tar zxvf - \
  && chmod +x steamcmd.sh \
  && ./steamcmd.sh +quit

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
