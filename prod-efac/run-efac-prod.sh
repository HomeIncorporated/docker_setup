#!/bin/bash

INFRA_PROJECT=nimbleinfra-efac-prod
SERVICE_PROJECT=nimbleservices-efac-prod

# run infrastructure
if [[ "$1" = "infra" ]]; then

	docker-compose -f infra/docker-compose-prod-efac.yml --project-name ${INFRA_PROJECT} up --build -d

elif [[ "$1" = "database" ]]; then

	docker-compose -f infra/docker-compose-prod-efac.yml --project-name ${INFRA_PROJECT} up -d efac-main-db

elif [[ "$1" = "keycloak" ]]; then

	docker-compose -f infra/keycloak/docker-compose-prod-efac.yml --project-name ${INFRA_PROJECT} up --build -d

elif [[ "$1" = "solr" ]]; then

	docker-compose -f infra/solr/docker-compose.yml --project-name ${INFRA_PROJECT} up -d

#elif [[ "$1" = "services" ]]; then
#
#	# update services
#	docker-compose -f services/docker-compose.yml --project-name ${SERVICE_PROJECT} pull
#
#	# start services
#	docker-compose -f services/docker-compose.yml --project-name ${SERVICE_PROJECT} up \
#		-d \
#		--build \
#		identity-service business-process-service frontend-service catalog-service-srdc frontend-service-sidecar search-service
#
#elif [[ "$1" = "start" ]]; then
#
#	update_images
#	start_all
#
elif [[ "$1" = "restart-single" ]]; then

	# update services
	docker-compose -f services/docker-compose-prod-efac.yml --project-name ${SERVICE_PROJECT} pull $2

	# restart service
	docker-compose -f services/docker-compose-prod-efac.yml --project-name ${SERVICE_PROJECT} up --build -d --force-recreate $2

elif [[ "$1" = "service-logs" ]]; then

	docker-compose -f services/docker-compose-prod-efac.yml --project-name ${SERVICE_PROJECT} logs -f $2

elif [[ "$1" = "services-logs" ]]; then

	docker-compose -f services/docker-compose-prod-efac.yml --project-name ${SERVICE_PROJECT} logs -f

else
    echo "Invalid usage"
    exit 2
fi
