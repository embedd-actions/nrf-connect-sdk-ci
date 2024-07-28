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
      uses: embedd-actions/nrf-connect-sdk-ci@v2.6.1
      with:
        board: nrf52833dk_nrf52833
        build_dir: build

```

## How to specify a version of NRF Connect SDK

To select the specific version of  NRF Connect SDK you
can reference a specific version of GitHub action:
```
uses: embedd-actions/nrf-connect-sdk-ci@v2.3.0
uses: embedd-actions/nrf-connect-sdk-ci@v2.4.0
uses: embedd-actions/nrf-connect-sdk-ci@v2.6.1
```

## List of available tags

```
v2.3.0
v2.4.0
v2.4.1
v2.4.2
v2.5.0
v2.5.1
v2.6.1
```
