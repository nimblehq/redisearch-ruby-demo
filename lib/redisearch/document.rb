require_relative '../string_extensions'

module RediSearch
  class Document
    using ::StringExtensions

    class << self
      # This class defines methods for searching and listing the records in redis

      # Lists all documents in a index
      # @param [String] index_name
      # @param [Class] klass
      # @param [Hash] filters
      # @param [Hash] paging
      # @param [Hash] sort
      def list(**args)
        search(**args.merge(term: nil))
      end

      # Performs searching on a index for a particual term
      # @param [String] index_name
      # @param [String] term
      # @param [Class] klass You can specify the underlying object class for mapping the results
      # @param [Hash] filters
      # @param [Hash] paging
      # @param [Hash] sort
      # Example Usage:
      # RediSearch::Document.search(index_name: "business-products-1",
      #                             term: "app",
      #                             klass: Product,
      #                             filters: { stock_quantity: { min: 0, max: 4 } },
      #                             paging: { limit: 10, offset: 0 },
      #                             sort: { key: :stock_quantity, direction: :desc })
      # rubocop:disable Metrics/ParameterLists
      def search(index_name:, term: nil, klass: nil, filters: {}, paging: {}, sort: {})
        command = build_query(index_name: index_name, term: term)
        command = apply_filters(command: command, filters: filters) unless filters.empty?
        command = apply_pagination(command: command, paging: paging) unless paging.empty?
        command = apply_sorting(command: command, sort: sort) unless sort.empty?

        parse_results(value: REDIS.call(command.split(' ')), klass: klass)
      end
      # rubocop:enable Metrics/ParameterLists

      private

      def build_query(index_name:, term: nil)
        query = '*'
        query.prepend(term.escape_special_characters) unless term.nil?

        "FT.SEARCH #{index_name} #{query}"
      end

      def apply_filters(command:, filters:)
        filters.each do |key, range|
          command << " FILTER #{key} #{range[:min]} #{range[:max]}"
        end

        command
      end

      def apply_pagination(command:, paging:)
        command << " LIMIT #{paging[:offset]} #{paging[:limit]}"
      end

      def apply_sorting(command:, sort:)
        command << " SORTBY #{sort[:key]} #{sort[:direction]}"
      end

      def parse_results(value:, klass: nil)
        # Redis returns the results in following example form
        # [2, "doc:3", ["name", "Grape Juice", "stock_quantity", "4", "minimum_stock", "2"], "doc:4", ["name", "Apple Juice", "stock_quantity", "4", "minimum_stock", "2"]]
        # Where first value is count of results, then every 2 elements are document_id, attributes respectively.
        results = []
        value.shift
        value.each_slice(2).each do |document_id, attributes|
          record_attributes = attributes.each_slice(2).to_h
            .transform_keys!(&:to_sym)
            .merge(document_id: document_id)

          record = !klass.nil? ? klass.new(record_attributes) : record_attributes
          results << record
        end

        results
      end
    end
  end
end
