#!/bin/bash

docker stop mybrother && docker rm mybrother && docker-compose up -d && docker-compose exec mybrother /bin/bash