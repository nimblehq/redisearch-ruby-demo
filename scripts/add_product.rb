require 'redis'

Dir[File.expand_path "lib/**/*.rb"].each { |f| require_relative(f) }

product = Product.new(id: ARGV[0], name: ARGV[1], quantity: ARGV[2])

REDIS.mapped_hmset("products:#{product.id}", product.attributes)
