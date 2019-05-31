[TOC]

## Requirements

| Tools      | Version | URL                        |
| ---------- | ------- | -------------------------- |
| ruby       | 2.5     | https://www.ruby-lang.org/ |
| capistrano | 3.8.1   | http://capistranorb.com/   |

## How to setup

### Build the deployment's docker image

```
#!bash
$ docker build --rm -f Dockerfile -t capistrano-learning:latest .
```

### Run the deployment's container

```
#!bash
$ docker run -it --rm --name=capistrano-learning -v $(pwd):/src capistrano-learning
```

### (Optional) Restart the deployment's container after reboot your machine

```
#!bash
$ docker start capistrano-learning
```

### How to deploy

```
#!bash
$ cap <stage><env-name> deploy
```

| stage     | command                  |
| --------- | ------------------------ |
| admin-api | cap admin-api:dev deploy |
| store-api | cap store-api:dev deploy |
| admin-web | cap admin-web:dev deploy |
| store-web | cap store-web:dev deploy |
| cast-web  | cap cast-web:dev deploy  |
| user-web  | cap user-web:dev deploy  |
