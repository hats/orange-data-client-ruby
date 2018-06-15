# frozen_string_literal: true

require 'openssl'

module OrangeData
  class Client
    class Auth < Faraday::Middleware
      include OrangeData::PipelineMixin

      def initialize(app, organization_key)
        @context = {
          app: app,
          organization_key: organization_key
        }
      end

      def call(env)
        run_pipeline(
          @context.merge(env: env),
          [:generate_digest,
           :generate_signature,
           :encode_signature,
           :update_env,
           :return_new_env
          ]
        ).result
      end

      private

      def generate_digest(context)
        Succ.new(context.tap { |ctx| ctx[:digest] = OpenSSL::Digest::SHA256.new })
      end

      def generate_signature(context)
        Succ.new(context.tap { |ctx| ctx[:raw_signature] = ctx[:organization_key].sign(ctx[:digest], ctx[:env].body) })
      end

      def encode_signature(context)
        Succ.new(context.tap { |ctx| ctx[:signature] = Base64.strict_encode64(ctx[:raw_signature]) })
      end

      def update_env(context)
        Succ.new(context.tap { |ctx| ctx[:env] = ctx[:env].tap { |e| e.request_headers['X-Signature'] = ctx[:signature] } })
      end

      def return_new_env(context)
        Succ.new(
          context[:app].call(context[:env])
        )
      end
    end

    Faraday::Request.register_middleware(orange_data_auth: Auth)
  end
end
