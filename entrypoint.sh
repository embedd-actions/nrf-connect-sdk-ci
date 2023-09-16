#!/bin/bash

#echo 'export PATH=root/gn:"$PATH"' >> ${HOME}/.bashrc

#. ${HOME}/.bashrc

#echo 'export PATH=root/.local/bin:"$PATH"' >> ~/.bashrc

#. ~/.bashrc

. /root/gn/zephyr/zephyr-env.sh
/bin/bash /root/zephyr-sdk-${ZEPHYR_TAG}/setup.sh -t all
/bin/bash /root/zephyr-sdk-${ZEPHYR_TAG}/setup.sh -h
/bin/bash /root/zephyr-sdk-${ZEPHYR_TAG}/setup.sh -c

$@
