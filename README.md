# rja-blob-lister
A simple lister which return a list of the dates where the playback logs for RJA are available. 

## Usage
1. Specify your Azure Blob Storage account information in one of the following ways:
    - Write them in `.rjarc` file.
        ```sh
        account:<account_name>
        container:<container_name>
        token:<account_SAS>
        ```
        > **Note**
        > You can change the directory and filename of `.rjarc` diting the following line in `rja.sh`:
        > https://github.com/KeisukeKonta/rja-blob-lister/blob/82d697ba800c81380082f935a932e04c9a5c970f/rja.sh#L1
    - Write them directly on the following lines in `rja.sh`:
        https://github.com/KeisukeKonta/rja-blob-lister/blob/82d697ba800c81380082f935a932e04c9a5c970f/rja.sh#L3-L5
    - Specify them as command options:
        ```sh
        rja -a <account_name> -c <container_name> -t <account_SAS>
        ```
    Priority is as follows: `command options` > `rja.sh (source code)` > `.rjarc`
2. Run `rja.sh`:
    ```sh
    bash rja.sh
    Collecting data from https://<account_name>.blob.core.windows.net/<container_name> ...
    Currently, playback logs are available on following dates:
    2022年
      ├── 06月
      │   ├── 24日 ── 14 15 16
      │   ├── 25日 ── 07 08 09 10 11 12 13 14 15 16
      │   ├── 27日 ── 07 08 09 10 11
      │   ├── 28日 ── 07 08 09 10 11 12 13 14 15 16
      │   ├── 29日 ── 07 08 09 10 11 12 13 14 15 16
      │   └── 30日 ── 07 08 09 10 11 12 13 14 15 16
      ├── 07月
      │   ├── 01日 ── 07 08 09 10 11 12 13 14 15 16
      │   ├── 02日 ── 07 08 09 10 11 12 13 14 15 16
      │   ├── 04日 ── 07 08 09 10 11 12 13 14 15 16
      │   ├── 05日 ── 07 08 09 10 11 12 13 14 15 16
      │   ├── 06日 ── 07 08 09 10 12 13 14 15 16
      │   ├── 07日 ── 07 08 09 10 11 12 13 14 15 16
      │   ├── 08日 ── 07 08 09 10 11
      │   ├── 09日 ── 07 08 09 10 11 12 13 14 15 16
      │   ├── 11日 ── 07 08 09 10 11 12 13 14 15 16
      │   ├── 12日 ── 07 08 09 10 11 12 13 14 15 16
      │   └── 13日 ── 07 08 09 10 11 12 13 14 15 16
      ├── 08月
      │   ├── 18日 ── 07 08 09 10 11
      │   ├── 19日 ── 09 10 11 12 13 14
      │   ├── 20日 ── 07 08 09 10 11
      │   ├── 22日 ── 07 08 09 10 11 12 13 14 15 16
      │   ├── 23日 ── 07 08 09 10 11 14 15 16
      │   ├── 24日 ── 07 08 09 10 11 13 14 15 16
      │   ├── 25日 ── 07 08 09 10 11 12 13 14 15 16
      │   ├── 26日 ── 07 08 09 10 11 12 13 14 15 16
      │   ├── 27日 ── 09 10 11 12 13
      │   ├── 29日 ── 07 08 09 10 11 12 13 14 15 16
      │   ├── 30日 ── 07 08 09 10 11 12 13 14 15 16
      │   └── 31日 ── 08 09 10 11 12 13 14 15 16
      └── 09月
          ├── 01日 ── 07 08 09 10 11 12 13 14 15 16
          ├── 02日 ── 08 09 10 11 12 13 14 15 16
          ├── 03日 ── 07 08 09
          ├── 05日 ── 07 08 09 10 11 12 13 14 15 16
          ├── 06日 ── 12 13 14 15 16
          ├── 07日 ── 07 08 09 10 11 12 13 14 15 16
          ├── 08日 ── 07 08 09 10 11 12 13 14 15 16
          ├── 09日 ── 07 08 09 10 11 12 13 14 15 16
          ├── 10日 ── 08 09 10 11 13 14 15
          ├── 12日 ── 07 08 09 10 11 12 13 14 15 16
          ├── 13日 ── 08 09 10 11 12 13 14
          ├── 14日 ── 12 13 14 15 16
          └── 15日 ── 12 13
    ```