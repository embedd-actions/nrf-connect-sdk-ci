#!/bin/bash

. /workdir/ncs/zephyr/zephyr-env.sh
/bin/bash /workdir/zephyr-sdk-${ZEPHYR_TAG}/setup.sh -t arm-zephyr-eabi
/bin/bash /workdir/zephyr-sdk-${ZEPHYR_TAG}/setup.sh -c

if [ "$INPUT_SYSBUILD" = "false" ]; then
    west build --build-dir "$INPUT_BUILD_DIR" . --pristine --no-sysbuild --board "$INPUT_BOARD"
else
    west build --build-dir "$INPUT_BUILD_DIR" . --pristine --board "$INPUT_BOARD"
fi
