# redisearch-ruby-demo

## About
This repo provides a small demo for using RediSearch with ruby

## Dependences
docker, docker-compose

## Installation

Run the following commands to install using docker

```
docker-compose build
docker-compose up
```
This would build and run the image, as well as add some seed data into Redis. (comprising of products)

## Usage

```
docker ps # Get the container id of the app
docker exec -it {container_id} /bin/bash
```

* To search for a product from seed data

```
ruby scripts/search_product.rb Jui
ruby scripts/search_product.rb Man
```

* To add a new product

```
ruby scripts/add_product.rb #{id} #{name} #{quantity}
ruby scripts/add_product.rb 1 Apple 5
```

