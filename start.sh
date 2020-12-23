#!/bin/bash

ruby scripts/create_schema.rb

echo "Adding product with {id: 1, name: 'Mango-Juice' quantity: 2}"
ruby scripts/add_product.rb 1 Mango-Juice 2

echo "Adding product with {id: 2, name: 'Apple-Juice' quantity: 4}"
ruby scripts/add_product.rb 2 Apple-Juice 4

echo "Adding product with {id: 3, name: 'Mango-Smoothie' quantity: 5}"
ruby scripts/add_product.rb 3 1 Mango-Smoothie 5

echo "Adding product with {id: 4, name: 'Grapes' quantity: 2}"
ruby scripts/add_product.rb 4 Grapes 2

echo "Adding product with {id: 5, name: 'Grape-Juice' quantity: 4}"
ruby scripts/add_product.rb 5 Grape-Juice 4

echo "Adding product with {id: 6, name: 'Orange-Smoothie' quantity: 8}"
ruby scripts/add_product.rb 6 Orange-Smoothie 8

while true
do
    echo "Completed adding the products"
    echo "App container is running, you can exec into container shell to run search commands"
    echo "Press [CTRL+C] to stop.."
    sleep 1
done

