module RediSearch
  class Index
    class << self
      def create(name:, prefix:, schema:)
        command = "FT.CREATE #{name} ON HASH PREFIX 1 #{prefix} SCHEMA #{schema.to_a.flatten.join(' ')}"
        REDIS.call(command.split(' '))
      end

      def destroy(name:, destroy_documents: true)
        command = "FT.DROPINDEX #{name}"
        command << ' DD' if destroy_documents

        REDIS.call(command.split(' '))
      end

      def info(name:)
        REDIS.call('FT.INFO', name)
      end
    end
  end
end
