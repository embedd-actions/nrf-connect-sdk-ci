# nrf-connect-sdk-ci
Build NRF Connect SDK projects

## Usage example:

```yml
jobs:
  build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v4


    - name: Build
      uses: embedd-actions/nrf-connect-sdk-ci@v3.0.2
      with:
        board: <DK Board Name>
        build_dir: build
        sysbuild: 'true/false'

```

## How to specify a version of NRF Connect SDK

To select the specific version of  NRF Connect SDK you
can reference a specific version of GitHub action:
```yml
uses: embedd-actions/nrf-connect-sdk-ci@v2.3.0
uses: embedd-actions/nrf-connect-sdk-ci@v2.4.0
uses: embedd-actions/nrf-connect-sdk-ci@v2.6.1
uses: embedd-actions/nrf-connect-sdk-ci@v2.7.0
uses: embedd-actions/nrf-connect-sdk-ci@v2.8.0
uses: embedd-actions/nrf-connect-sdk-ci@v2.9.0
uses: embedd-actions/nrf-connect-sdk-ci@v2.9.1
uses: embedd-actions/nrf-connect-sdk-ci@v3.0.0
uses: embedd-actions/nrf-connect-sdk-ci@v3.0.1
uses: embedd-actions/nrf-connect-sdk-ci@v3.0.2
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
v2.7.0
v2.8.0
v2.8.0
v2.9.0
v2.9.1
v3.0.0
v3.0.1
v3.0.2
```
