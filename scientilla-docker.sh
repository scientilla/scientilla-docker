#!/usr/bin/env bash
set -e

source .env

case $1 in
    start)
        case "$ENVIRONMENT" in
            development)
                echo "Starting Scientilla in development mode ..."
                docker-compose -f docker-compose.yml -f docker-compose-development.yml up -d --build
            ;;

            staging)
                echo "Starting Scientilla in staging mode ..."
                docker-compose -f docker-compose.yml -f docker-compose-staging.yml up -d --build
            ;;

            production)
                echo "Starting Scientilla in production mode ..."
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

    test)
        case "$ENVIRONMENT" in
            development)
                echo "Starting Scientilla testing in development mode ..."
                docker-compose -f docker-compose-testing-development.yml up -d db-test
                docker-compose -f docker-compose-testing-development.yml logs -f db-test > docker/db-test/logs &
                sleep 1
                docker-compose -f docker-compose-testing-development.yml run --rm npm test
                docker-compose -f docker-compose-testing-development.yml stop db-test
                docker-compose -f docker-compose-testing-development.yml rm -f db-test
            ;;

            *)
                echo "Testing only configured for development ..."
                echo $"Usage: $1 {development}"
            ;;
        esac
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
