# nrf-connect-sdk-ci
Build NRF Connect SDK projects

## Usage example:

```
jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3


    - name: Build
      uses: embedd-actions/nrf-connect-sdk-ci@v2.3.0
      with:
        board: nrf52833dk_nrf52833
        build_dir: build

```
