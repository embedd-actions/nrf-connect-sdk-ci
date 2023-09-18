FROM debian:stable-slim

#ARG ARCH=amd64
ARG NRF_CONNECT_TAG=v2.4.1
# Should be for selected NRF_CONNECT_TAG
ARG ZEPHYR_NEEDED_TAG=0.16.0
# For new versions - xz
ARG ZEPHYR_ARCHIVE_EXTENSION=xz

# For entrypoint file
ENV ZEPHYR_TAG=$ZEPHYR_NEEDED_TAG

RUN ARCH="$(dpkg --print-architecture)" && \
    case $ARCH in \
    "amd64") \
        ZEPHYR_ARCH="x86_64" \
        ;; \
    "arm64") \
        ZEPHYR_ARCH="aarch64" \
        ;; \
    esac && \
    apt-get update && \
    apt-get install \
    --no-install-recommends \
    git \
    cmake \
    ninja-build \
    gperf \
    ccache \
    dfu-util \
    device-tree-compiler \
    wget \
    python3-dev \
    python3-pip \
    python3-setuptools \
    python3-tk \
    python3-wheel \
    xz-utils \
    file \
    make \
    gcc \
    libsdl2-dev \
    libmagic1 \
    unzip \
    build-essential \
    libgit2-dev \
    -y && \
    rm -rf /var/cache/apt && \
    pip3 install --upgrade pip --break-system-packages && \
    mkdir ${HOME}/gn && \
    cd ${HOME}/gn && \
    wget -O gn.zip https://chrome-infra-packages.appspot.com/dl/gn/gn/linux-$ARCH/+/latest &&\
    unzip gn.zip && \
    rm gn.zip && \
    echo 'export PATH=${HOME}/gn:"$PATH"' >> ${HOME}/.bashrc && \
    . ${HOME}/.bashrc && \
    pip3 install west --break-system-packages && \
    echo 'export PATH=~/.local/bin:"$PATH"' >> ~/.bashrc && \
    . ~/.bashrc && \
    west init -m https://github.com/nrfconnect/sdk-nrf --mr $NRF_CONNECT_TAG && \
    west update && \
    west zephyr-export && \
    pip3 install -r zephyr/scripts/requirements.txt --break-system-packages && \
    pip3 install -r nrf/scripts/requirements.txt --break-system-packages && \
    pip3 install -r bootloader/mcuboot/scripts/requirements.txt --break-system-packages && \
    cd ~ && \
    wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${ZEPHYR_TAG}/zephyr-sdk-${ZEPHYR_TAG}_linux-${ZEPHYR_ARCH}.tar.${ZEPHYR_ARCHIVE_EXTENSION} && \
    (wget -O - https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${ZEPHYR_TAG}/sha256.sum | shasum --check --ignore-missing) && \
    tar xvf zephyr-sdk-${ZEPHYR_TAG}_linux-$ZEPHYR_ARCH.tar.${ZEPHYR_ARCHIVE_EXTENSION} && \
    rm zephyr-sdk-${ZEPHYR_TAG}_linux-$ZEPHYR_ARCH.tar.${ZEPHYR_ARCHIVE_EXTENSION} && \
    apt-get remove python3-pip build-essential -y && \
    apt autoremove -y && \
    apt autoclean -y && \
    find ./zephyr-sdk-${ZEPHYR_TAG} -maxdepth 1 -not -name zephyr-sdk-${ZEPHYR_TAG} -not -name 'arm-zephyr-eabi' -not -name 'cmake' -not -name 'sdk_*' -not -name '*.sh' -exec rm -R {} \;

COPY ./entrypoint.sh /bin/

RUN chmod +x /bin/entrypoint.sh

ENTRYPOINT [ "/bin/entrypoint.sh" ]
