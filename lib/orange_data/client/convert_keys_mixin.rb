# frozen_string_literal: true

module OrangeData
  class Client
    module ConvertKeysMixin
      private

      def convert_keys(value)
        case value
        when Array
          value.map(&method(:convert_keys))
        when Hash
          Hash[value.map { |k, v| [convert_key(k), convert_keys(v)] }]
        else
          value
        end
      end

      def convert_key(key)
        orange_data_keys[key] || key.to_sym
      end
    end
  end
end
