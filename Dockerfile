FROM debian:stable-slim

#ARG ARCH=amd64
ARG NRF_CONNECT_TAG=v2.6.1
# Should be for selected NRF_CONNECT_TAG
ARG ZEPHYR_NEEDED_TAG=0.16.5-1
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
    # Get nessecary packages
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
    # Remove apt cache
    rm -rf /var/cache/apt && \
    pip3 install --upgrade pip --break-system-packages && \
    # Create work directory
    mkdir /workdir && \
    # Get GN tools for matter
    cd /usr/bin && \
    wget -O gn.zip https://chrome-infra-packages.appspot.com/dl/gn/gn/linux-$ARCH/+/latest &&\
    unzip gn.zip && \
    rm gn.zip && \
    # Install west
    pip3 install west --break-system-packages && \
    cd /workdir && \
    mkdir ncs && \
    cd ncs && \
    # Get NRF SDK code
    west init -m https://github.com/nrfconnect/sdk-nrf --mr $NRF_CONNECT_TAG && \
    west update && \
    west zephyr-export && \
    pip3 install -r zephyr/scripts/requirements.txt --break-system-packages && \
    pip3 install -r nrf/scripts/requirements.txt --break-system-packages && \
    pip3 install -r bootloader/mcuboot/scripts/requirements.txt --break-system-packages && \
    cd /workdir && \
    # Get toolchain (minimal)
    wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${ZEPHYR_TAG}/zephyr-sdk-${ZEPHYR_TAG}_linux-${ZEPHYR_ARCH}_minimal.tar.${ZEPHYR_ARCHIVE_EXTENSION} && \
    (wget -O - https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v${ZEPHYR_TAG}/sha256.sum | shasum --check --ignore-missing) && \
    tar xvf zephyr-sdk-${ZEPHYR_TAG}_linux-${ZEPHYR_ARCH}_minimal.tar.${ZEPHYR_ARCHIVE_EXTENSION} && \
    rm zephyr-sdk-${ZEPHYR_TAG}_linux-${ZEPHYR_ARCH}_minimal.tar.${ZEPHYR_ARCHIVE_EXTENSION} && \
    # Remove unused packages
    apt-get remove python3-pip build-essential -y && \
    apt autoremove -y && \
    apt autoclean -y && \
    # Install arm-zephyr-eabi toolchain for NRF
    ./zephyr-sdk-${ZEPHYR_TAG}/setup.sh -t arm-zephyr-eabi && \
    ./zephyr-sdk-${ZEPHYR_TAG}/setup.sh -c

ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
