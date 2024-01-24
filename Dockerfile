# Base Image
FROM debian:12.2

# this is just a default
ENV TZ=America/New_York

ARG DEBIAN_FRONTEND=noninteractive
ARG MLAPI_REF=6b68dc15cc66b1fc20a587872369793dcf676fee
ARG PYZM_REF=d5925e56e1e8c78053914ef586d394f053fd50e5

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
RUN git clone https://github.com/ZoneMinder/pyzm.git /pyzm \
    && cd /pyzm \
    && git checkout $PYZM_REF \
    && pip install --break-system-packages . \
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
