require 'redis'
Dir[File.expand_path "lib/**/*.rb"].each { |f| require_relative(f) }

RediSearch::Index.create(name: 'products', prefix: 'products:', schema: { id: 'NUMERIC SORTABLE', name: 'TEXT SORTABLE', quantity: 'NUMERIC SORTABLE' })
