# Scientilla dockerized

This package is been created to collect all the configurations to run Scientilla in a Docker environment. In this way the Scientilla project itself will be cleaner and not contain any Docker configuration.

## Setup .env file

We need to create an .env file with some custom configuration. You can find an example of this file in the root folder of this project: example.env

```
ENVIRONMENT=                          Name of the environment can be development, staging or production
WEB_APPLICATION_PORT=                 The port setting determines which TCP port will used to listen for incoming requests
WEB_APPLICATION_URL=                  The url determines the location of the application

DATABASE_HOST=                        Database host
DATABASE_PORT=                        Database port
DATABASE_NAME=                        Database name
DATABASE_USER=                        Database user
DATABASE_PASSWORD=                    Database password

FORCE_INSTALLER=                      (true or false) Force showing the installer even the application is ready to start
ALLOWED_IP=                           Make the installer only available from a specific IP

SCIENTILLA_VOLUME=                    Relative path to the Scientilla code folder starting from this project folder (only for development)

DOCKER_IMAGE=                         Location of the docker image that will be used in production

```

## Scientilla configuration
Please complete the scientilla configuration with the installer.

## Scientilla docker commands

### Start
Start the services of Scientilla
```
./scientilla-docker.sh start
```

### Stop
Stop the services of Scientilla
```
./scientilla-docker.sh stop
```

### Restart
Restart the web service
```
./scientilla-docker.sh restart
```

### Down
Stop the containers and remove the containers, networks, volumes, and images.
```
./scientilla-docker.sh down
```

### Logs
Show all the logs of the web service
```
./scientilla-docker.sh logs
```

### Backup
Create a backup of the database by using the following command. The postfix will be added to the filename.
```
./scientilla-docker.sh backup create POSTFIX
```

Restore the database with a backup by using the following command. The file should be available inside the backups folder.
```
./scientilla-docker.sh backup restore dump.sql
```