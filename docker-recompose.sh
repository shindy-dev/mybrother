#!/bin/bash

docker stop mybrother || true && docker rm mybrother || true && docker-compose up -d && docker-compose exec mybrother /bin/bash