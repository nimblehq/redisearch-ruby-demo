require_all '../lib'

p RediSearch::Document.search(index_name: 'products', term: ARGV[0], klass: Product)
