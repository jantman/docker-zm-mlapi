# Base Image
FROM debian:12.2

# this is just a default
ENV TZ=America/New_York

ARG DEBIAN_FRONTEND=noninteractive
ARG MLAPI_REF=0eb66e657e51e26a4423a6dbd36890eab6162006

# dependency installation
RUN apt update \
    && apt-get upgrade --yes \
    && apt-get install --yes \
         build-essential \
         cmake \
         git \
         libev-dev \
         libevdev2 \
         lsb-release \
         python3-pip \
         python3-requests \
         python3-opencv \
         wget \
    && apt-get clean

# @TODO replace python3-opencv above with OpenCV > 4.3 with GPU support

# mlapi installation
RUN git clone https://github.com/jantman/pyzm.git /pyzm \
    && cd /pyzm \
    && git checkout jantman \
    && pip install --break-system-packahes . \
    && git clone https://github.com/ZoneMinder/mlapi.git /mlapi \
    && cd /mlapi \
    && git checkout $MLAPI_REF \
    && pip install --break-system-packages -r requirements.txt \
    && ./get_models.sh

# Copy entrypoint make it as executable and run it
COPY entrypoint.sh /opt/
RUN chmod +x /opt/entrypoint.sh

ENTRYPOINT [ "/bin/bash", "-c", "source ~/.bashrc && /opt/entrypoint.sh ${@}", "--" ]

VOLUME /var/lib/zmeventnotification

EXPOSE 80
