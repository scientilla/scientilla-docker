#!/usr/bin/env bash

source .env

touch docker/web/config/local.js
touch docker/web/config/scientilla.js
touch docker/web/config/customizations.js

case $1 in
    start)
        case "$ENVIRONMENT" in
            development)
                echo "Starting Scientilla in development mode ..."
                docker-compose -f docker-compose.yml -f docker-compose-development.yml up -d --build
            ;;

            staging|production)
                echo "Starting Scientilla in $ENVIRONMENT mode ..."
                docker-compose -f docker-compose.yml -f docker-compose-production.yml build --no-cache web
                docker-compose -f docker-compose.yml -f docker-compose-production.yml up -d
            ;;
        esac
    ;;

    stop)
        echo "Stopping Scientilla ..."

        case "$ENVIRONMENT" in
            development)
                docker-compose -f docker-compose.yml -f docker-compose-development.yml stop
            ;;

            staging|production)
                docker-compose -f docker-compose.yml -f docker-compose-production.yml stop
            ;;
        esac
    ;;

    restart)
        echo "Restarting web service of Scientilla ..."

        case "$ENVIRONMENT" in
            development)
                docker-compose -f docker-compose.yml -f docker-compose-development.yml restart web
            ;;

            staging|production)
                docker-compose -f docker-compose.yml -f docker-compose-production.yml restart web
            ;;
        esac
    ;;

    down)
        echo "Stopping Scientilla and removing containers, networks, volumes, and images..."

        case "$ENVIRONMENT" in
            development)
                docker-compose -f docker-compose.yml -f docker-compose-development.yml down
            ;;

            staging|production)
                docker-compose -f docker-compose.yml -f docker-compose-production.yml down
            ;;
        esac
    ;;

    logs)
        echo "Showing the logs of the web service..."

        case "$ENVIRONMENT" in
            development)
                docker-compose -f docker-compose.yml -f docker-compose-development.yml logs -f web
            ;;

            staging|production)
                docker-compose -f docker-compose.yml -f docker-compose-production.yml logs -f web
            ;;
        esac
    ;;

    bash)
        echo "Starting bash inside the web service..."

        case "$ENVIRONMENT" in
            development)
                docker-compose -f docker-compose.yml -f docker-compose-development.yml exec web /bin/sh
            ;;

            staging|production)
                docker-compose -f docker-compose.yml -f docker-compose-production.yml exec web /bin/sh
            ;;
        esac
    ;;

    backup)
        case "$2" in
            create)
                echo "Creating backup..."

                case "$ENVIRONMENT" in
                    development)
                        docker-compose -f docker-compose.yml -f docker-compose-development.yml exec web grunt backup:create:$3
                    ;;

                    staging|production)
                        docker-compose -f docker-compose.yml -f docker-compose-production.yml exec web grunt backup:create:$3
                    ;;
                esac
            ;;

            restore)
                echo "Restoring backup..."
                path=$3

                case "$ENVIRONMENT" in
                    development)
                        docker-compose -f docker-compose.yml -f docker-compose-development.yml exec web grunt backup:restore:${path##*/}
                    ;;

                    staging|production)
                        docker-compose -f docker-compose.yml -f docker-compose-production.yml exec web grunt backup:restore:${path##*/}
                    ;;
                esac
            ;;

            *)
                echo "Command not found ..."
                echo $"Usage: $2 {create|restore}"
            ;;
        esac
    ;;

    *)
        echo "Command not found ..."
        echo $"Usage: $1 {start|stop|restart|down|logs|bash|backup}"
    ;;
esac
