# frozen_string_literal: true

require 'faraday_middleware'

require 'orange_data/client/auth'
require 'orange_data/client/convert_keys_mixin'
require 'orange_data/client/process_request_body'
require 'orange_data/client/process_response_body'
require 'orange_data/client/request'

module OrangeData
  class Client

    def self.request(payload, api_name:)
      new.request(payload, api_name: api_name)
    end

    attr_accessor :config

    def initialize(config: OrangeData.configuration)
      @config = config
    end

    def api_url
      config.api_url
    end

    def orange_data_certificate
      config.orange_data_certificate
    end

    def orange_data_key
      config.orange_data_key
    end

    def organization_key
      config.organization_key
    end

    def connection

      @connection ||= Faraday.new(
        url: api_url,
        ssl: {
          client_cert: orange_data_certificate,
          client_key: orange_data_key,
          verify: false
        }
      ) do |conn|
        conn.headers['User-Agent'] = 'Orange Data Ruby Client 1.0'
        conn.request(:process_request_body, config)
        conn.request(:json)
        conn.request(:orange_data_auth, organization_key)

        conn.response(:process_response_body, config)
        conn.response :json, content_type: /\bjson$/
        conn.response(:logger, nil, bodies: true) if config.debug
        conn.adapter(Faraday.default_adapter)
      end
    end

    def request(payload, api_name:)
      api_route_params(api_name, id: payload[:id], inn: payload[:inn] || config.inn).yield_self do |(api_method, api_path)|
        Request.new(payload, connection, api_method, api_path).run!
      end
    end

    private

    def api_route_params(name, id: nil, inn: config.inn)
      case name
      when :add_receipt
        [:post, "#{config.api_path}/documents/"]
      when :get_receipt_status
        [:get, "#{config.api_path}/documents/#{inn}/status/#{id}"]
      when :add_correction
        [:post, "#{config.api_path}/corrections/"]
      when :get_correction_status
        [:get, "#{config.api_path}/corrections/#{inn}/status/#{id}"]
      else
        raise name.inspect
      end
    end
  end
end
