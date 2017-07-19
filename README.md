# docker-inowas-api
The docker-config to setup the project

## Installation
Please copy the file `.env.dist` to `.env` and configure for your needs!

Open your `/etc/hosts` file and add the following entry:

```bash
172.17.0.1       inowas.local
```

## Running
To start this application, you have to use the `dev.sh` bash script. This is needed to use
some definitions to ensure that all applications can communicate with each other.

### On Linux

```bash
$ . dev.sh
```

### On Mac

```bash
$ source dev.sh
```
