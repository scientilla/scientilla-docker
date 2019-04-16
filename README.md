# Scientilla dockerized

This package is been created to collect all the configurations to run Scientilla in a Docker environment. In this way the Scientilla project itself will be cleaner and not contain any Docker configuration.

## Setup .env file

We need to create an .env file with some custom configuration. You can find an example of this file in the root folder of this project: example.env

```
ENVIRONMENT=                          Name of the environment can be development, staging or production
SAILS_PORT=                           The port setting determines which TCP port Scientilla will use to listen for incoming requests
DB_PORT=                              The port setting determines which TCP port postgres will use to listen for connections from the Scientilla application
GIT_BRANCH=                           Name of the branch that will be used (only for production or staging)
SCIENTILLA_VOLUME=                    Relative path to the Scientilla code folder starting from this project folder (only for development)

POSTGRES_DB=                          Database name
POSTGRES_USER=                        Username
POSTGRES_PASSWORD=                    Password
```

## Create database_structure.sql

When the volume of the database is empty the database will be created based on the **database_structure.sql** file inside the docker/db folder. Therefor you will have to provide this file. This file is been added to the .gitignore file.

## Scientilla configuration
**For development:**

Please complete the basic Scientilla configuration by copying scientilla/config/scientilla.js.example to scientilla/config/scientilla.js and personalize the settings. 

**For staging or production:**

Please complete the basic Scientilla configuration by copying scientilla/config/scientilla.js.example to scientilla-docker/docker/web/production/scientilla.js and personalize the settings. 


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
./scientilla-docker.sh backup:create:POSTFIX
```

Restore the database with a backup by using the following command. The file should be available inside the backups folder.
```
./scientilla-docker.sh backup:restore:dump.sql
```