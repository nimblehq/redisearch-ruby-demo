module RediSearch
  class Index
    class << self
      # Creates a new index
      # @param [String] name
      # @param [String] prefix
      # @param [Hash] schema
      # Example Usage:
      # RediSearch::Index.create(name: 'products', prefix: 'products:', schema: { id: 'NUMERIC SORTABLE', name: 'TEXT SORTABLE' })
      def create(name:, prefix:, schema:)
        command = "FT.CREATE #{name} ON HASH PREFIX 1 #{prefix} SCHEMA #{schema.to_a.flatten.join(' ')}"
        REDIS.call(command.split(' '))
      end

      # Destroys an existing index
      # @param [String] name
      # @param [Boolean] destroy_documents
      # Example Usage:
      # RediSearch::Index.destroy(name: 'products')
      def destroy(name:, destroy_documents: true)
        command = "FT.DROPINDEX #{name}"
        command << ' DD' if destroy_documents

        REDIS.call(command.split(' '))
      end

      # Get info on existing index
      # @param [String] name
      def info(name:)
        REDIS.call('FT.INFO', name)
      end
    end
  end
end
