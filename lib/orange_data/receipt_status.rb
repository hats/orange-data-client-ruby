# frozen_string_literal: true

module OrangeData
  class ReceiptStatus
    def initialize(id:, inn: nil, config: OrangeData.configuration)
      @config = config
      @id = id
      @inn = inn || @config.inn
    end

    def sync!
      Client.request(payload, api_name: :get_receipt_status)
    end

    private

    def payload
      @payload ||= {
        id: @id,
        inn: @inn
      }
    end
  end
end
