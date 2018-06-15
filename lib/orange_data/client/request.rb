# frozen_string_literal: true

module OrangeData
  class Client
    class Request
      include OrangeData::PipelineMixin

      def initialize(payload, connection, api_method, api_path)
        @context = {
          payload: payload,
          connection: connection,
          api_method: api_method,
          api_path: api_path
        }
      end

      def run!
        run_pipeline @context,
                     [:process,
                      :parse]
      end

      private

      def process(context)
        Succ.new(
          context[:connection].public_send(context[:api_method]) do |req|
            req.url context[:api_path]
            req.body = context[:payload]
          end
        )
      end

      def parse(response)
        response.success? ? Succ.new(response.body) : Fail.new(response.body[:errors])
      end
    end
  end
end
