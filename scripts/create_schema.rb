require_all '../lib'

RediSearch::Index.create(name: 'products', prefix: 'products:', schema: { id: 'NUMERIC SORTABLE', name: 'TEXT SORTABLE', quantity: 'NUMERIC SORTABLE' })
