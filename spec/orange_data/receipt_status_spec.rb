# frozen_string_literal: true

RSpec.describe OrangeData::ReceiptStatus, stub_config: true do
  describe '#sync!' do
    let(:id) { '5ff7e853-bf8d-4076-9511-e511b218dc44' }
    let(:inn) { '1234567890' }

    subject { described_class.new(id: id, inn: inn).sync! }

    let(:response) do
      {
        id: id,
        device_sn: '1400000000001394',
        device_rn: '0000000400054952',
        fs_number: '9999078900001341',
        ofd_name: 'ООО "Ярус" ("ОФД-Я")',
        ofd_website: 'www.ofd-ya.ru',
        ofd_inn: inn,
        fns_website: 'www.nalog.ru',
        company_inn: inn,
        company_name: 'Ромашка ООО',
        document_number: 5471,
        shift_number: 7505,
        document_index: 8375,
        processed_at: '2018-06-08T13:55:00',
        content:
          {
            type: :income,
            positions: [
              {
                quantity: 1.0,
                price: 100.0,
                tax: :vat_not_charged,
                text: 'Test',
                payment_method_type: :full_calculation,
                payment_subject_type: :service,
                nomenclature_code: 'Test'
              }
            ],
            check_close: {
              payments: [
                {
                  type: :card,
                  amount: 100.0
                }
              ],
              taxation_system: :osn
            },
            customer_contact: '+79991234567',
            agent_type: :other_agent,
            payment_transfer_operator_phone_numbers: ['+79998887766'],
            payment_agent_operation: 'Операция агента',
            payment_agent_phone_numbers: ['+79998887766'],
            payment_operator_phone_numbers: ['+79998887766'],
            payment_operator_name: 'Наименование оператора перевода',
            payment_operator_address: 'Адрес оператора перевода',
            payment_operator_inn: inn,
            supplier_phone_numbers: ['+79998887766'],
            additional_user_attribute: {
              name: 'fio',
              value: 'Test Test Test'
            }
          },
        change: 0.0,
        fp: '849222697'
      }
    end

    let(:config) { OrangeData.configuration }

    let(:response_body) do
      {
        id: id,
        deviceSN: '1400000000001394',
        deviceRN: '0000000400054952',
        fsNumber: '9999078900001341',
        ofdName: 'ООО "Ярус" ("ОФД-Я")',
        ofdWebsite: 'www.ofd-ya.ru',
        ofdINN: inn,
        fnsWebsite: 'www.nalog.ru',
        companyINN: inn,
        companyName: 'Ромашка ООО',
        documentNumber: 5471,
        shiftNumber: 7505,
        documentIndex: 8375,
        processedAt: '2018-06-08T13:55:00',
        content:
          {
            type: OrangeData.configuration.receipt_types[:income],
            positions: [
              {
                quantity: 1.0,
                price: 100.0,
                tax: OrangeData.configuration.tax_types[:vat_not_charged],
                text: 'Test',
                paymentMethodType: OrangeData.configuration.payment_method_types[:full_calculation],
                paymentSubjectType: OrangeData.configuration.payment_subject_types[:service],
                nomenclatureCode: Base64.strict_encode64('Test')
              }
            ],
            checkClose: {
              payments: [
                {
                  type: OrangeData.configuration.payment_types[:card],
                  amount: 100.0
                }
              ],
              taxationSystem: OrangeData.configuration.taxation_system_types[:osn]
            },
            customerContact: '+79991234567',
            agentType: OrangeData.configuration.agent_types[:other_agent],
            paymentTransferOperatorPhoneNumbers: ['+79998887766'],
            paymentAgentOperation: 'Операция агента',
            paymentAgentPhoneNumbers: ['+79998887766'],
            paymentOperatorPhoneNumbers: ['+79998887766'],
            paymentOperatorName: 'Наименование оператора перевода',
            paymentOperatorAddress: 'Адрес оператора перевода',
            paymentOperatorINN: inn,
            supplierPhoneNumbers: ['+79998887766'],
            additionalUserAttribute: {
              name: 'fio',
              value: 'Test Test Test'
            }
          },
        change: 0.0,
        fp: '849222697'
      }
    end

    let(:request_body) { "{\"id\":\"#{id}\",\"inn\":\"#{inn}\"}" }

    before do
      stub_request(:get, "https://apip.orangedata.ru:2443/api/v2/documents/#{inn}/status/#{id}").
        with(
          body: request_body,
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Orange Data Ruby Client 1.0',
            'X-Signature' => signature(request_body)
          }).
        to_return(status: 200, body: response_body.to_json, headers: { 'Content-Type' => 'application/json' })
    end

    it 'return something' do
      expect(subject.result).to eq(response)
    end
  end
end
