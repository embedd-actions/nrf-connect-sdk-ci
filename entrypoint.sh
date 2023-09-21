#!/bin/bash

. /workdir/ncs/zephyr/zephyr-env.sh
/bin/bash /workdir/zephyr-sdk-${ZEPHYR_TAG}/setup.sh -t arm-zephyr-eabi
/bin/bash /workdir/zephyr-sdk-${ZEPHYR_TAG}/setup.sh -c

exec $@
