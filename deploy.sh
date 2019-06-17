#!/usr/bin/env bash
case $1 in
    prepare)
        cd /var/docker

        BRANCH_NAME=$2
        TAG=$3

        if [ -d "/var/docker/scientilla-"$BRANCH_NAME ]
        then
        echo "Deleting folder"
            cd scientilla-$BRANCH_NAME
            ./scientilla-docker.sh down

            cd ..
            rm -Rf scientilla-$BRANCH_NAME
        fi

        git clone https://github.com/scientilla/scientilla-docker.git scientilla-$BRANCH_NAME

        ENVIRONMENT=staging

        for i in {1..999}
        do
            TMP_SAILS_PORT=$((8000+$i))
            TMP_DB_PORT=$((5000+$i))

            if ! netstat -nlt | grep $TMP_SAILS_PORT >/dev/null && ! netstat -nlt | grep $TMP_DB_PORT >/dev/null;
            then
                echo "Sails application will run on port :$TMP_SAILS_PORT and postgressql database on port :$TMP_DB_PORT"

                SAILS_PORT=$TMP_SAILS_PORT
                DB_PORT=$TMP_DB_PORT
                break
            fi
        done

        echo ENVIRONMENT="$ENVIRONMENT" > ./scientilla-$BRANCH_NAME/.env
        echo NAME="$BRANCH_NAME" >> ./scientilla-$BRANCH_NAME/.env
        echo TAG="$TAG" >> ./scientilla-$BRANCH_NAME/.env
        echo SAILS_PORT="$SAILS_PORT" >> ./scientilla-$BRANCH_NAME/.env
        echo DB_PORT="$DB_PORT" >> ./scientilla-$BRANCH_NAME/.env

        echo POSTGRES_DB="$POSTGRES_DB" >> ./scientilla-$BRANCH_NAME/.env
        echo POSTGRES_USER="$POSTGRES_USER" >> ./scientilla-$BRANCH_NAME/.env
        echo POSTGRES_PASSWORD="$POSTGRES_PASSWORD" >> ./scientilla-$BRANCH_NAME/.env

        cd scientilla-$BRANCH_NAME
        git checkout gitlab-ci

        cp /var/docker/scientilla-presets/database_structure.sql ./docker/db/database_structure.sql

        cp /var/docker/scientilla-presets/scientilla.js ./docker/web/scientilla.js
    ;;

    start)
        BRANCH_NAME=$2

        cd /var/docker

        cd /var/docker/scientilla-$BRANCH_NAME
        ./scientilla-docker.sh start

        # Get IP
        IP_ADDRESS=$(hostname --ip-address)

        # Copy .env variables
        export $(grep -v '^#' ./.env | xargs -0)

        echo ""
        echo ""
        echo ""
        echo "#########################################################################################"
        echo "#                                                                                       #"
        echo "#      Scientilla is running on port :"$SAILS_PORT"                http://"$IP_ADDRESS":"$SAILS_PORT"       #"
        echo "#      PostgreSQL database is running on port :"$DB_PORT"              "$IP_ADDRESS":"$DB_PORT"       #"
        echo "#                                                                                       #"
        echo "#########################################################################################"
        echo ""
        echo ""
        echo ""
    ;;

    *)
        echo "Command not found ..."
        echo $"Usage: $1 {prepare|start}"
    ;;
esac
