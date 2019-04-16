#!/usr/bin/env bash

source .env

case $1 in
    start)
        case "$ENVIRONMENT" in
            development)
                echo "Starting Scientilla in development mode ..."
                docker-compose -f docker-compose.yml -f docker-compose-development.yml up -d --build
            ;;

            staging|production)
                echo "Starting Scientilla in $ENVIRONMENT mode ..."
                docker-compose -f docker-compose.yml -f docker-compose-production.yml up -d --build
            ;;
        esac
    ;;

    stop)
        echo "Stopping Scientilla ..."
        docker-compose stop
    ;;

    restart)
        echo "Restarting web service of Scientilla ..."
        docker-compose restart web
    ;;

    down)
        echo "Stopping Scientilla and removing containers, networks, volumes, and images..."
        docker-compose down
    ;;

    logs)
        echo "Showing the logs of the web service..."
        docker-compose logs -f web
    ;;

    backup)
        case "$2" in
            create)
                echo "Creating backup..."
                docker-compose exec web grunt backup:create:$3
            ;;

            restore)
                echo "Restoring backup..."
                path=$3
                docker-compose exec web grunt backup:restore:${path##*/}
            ;;

            *)
                echo "Command not found ..."
                echo $"Usage: $2 {create|restore}"
            ;;
        esac
    ;;

    *)
        echo "Command not found ..."
        echo $"Usage: $1 {start|stop|restart|down|logs|backup}"
    ;;
esac
