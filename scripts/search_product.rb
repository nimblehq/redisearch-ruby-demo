require 'redis'
Dir[File.expand_path "lib/**/*.rb"].each { |f| require_relative(f) }

p RediSearch::Document.search(index_name: 'products', term: ARGV[0], klass: Product)
