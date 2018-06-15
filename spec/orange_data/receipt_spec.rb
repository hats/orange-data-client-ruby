# frozen_string_literal: true

RSpec.describe OrangeData::Receipt, stub_config: true do
  let(:id) { '99cde805-ed9a-4e08-8104-6bae6ffbfd31' }
  let(:inn) { '1234567890' }
  let(:group) { 'Main' }
  let(:key) { '1234567890' }
  let(:receipt_type) { :income }
  let(:customer_contact) { '+79991234567' }
  let(:taxation_system) { :osn }

  let(:quantity) { 1 }
  let(:price) { 100 }
  let(:text) { 'Test' }
  let(:tax) { :vat_not_charged }
  let(:payment_method_type) { :full_calculation }
  let(:payment_subject_type) { :service }
  let(:nomenclature_code) { 'Test' }

  let(:payment_type) { :card }
  let(:amount) { 100 }

  let(:agent_type) { :other_agent }
  let(:payment_transfer_operator_phone_numbers) { ['+79998887766'] }
  let(:payment_agent_operation) { 'Операция агента' }
  let(:payment_agent_phone_numbers) { ['+79998887766'] }
  let(:payment_operator_phone_numbers) { ['+79998887766'] }
  let(:payment_operator_name) { 'Наименование оператора перевода' }
  let(:payment_operator_address) { 'Адрес оператора перевода' }
  let(:payment_operator_inn) { '1234567890' }
  let(:supplier_phone_numbers) { ['+79998887766'] }

  let(:name) { 'fio' }
  let(:value) { 'Test Test Test' }

  let(:receipt) do
    described_class.new(
      id: id,
      inn: inn,
      group: group,
      type: receipt_type,
      key: key,
      customer_contact: customer_contact,
      taxation_system: taxation_system
    )
  end


  describe '#add_position' do
    subject do
      receipt.add_position(
        quantity: quantity,
        price: price,
        text: text,
        tax: tax,
        payment_method_type: payment_method_type,
        payment_subject_type: payment_subject_type,
        nomenclature_code: nomenclature_code
      )
    end

    it 'returns self' do
      expect(subject).to be_a(described_class)
    end
  end

  describe '#add_payment' do
    subject do
      receipt.add_payment(type: payment_type, amount: amount)
    end

    it 'returns self' do
      expect(subject).to be_a(described_class)
    end
  end

  describe '#add_agent' do
    subject do
      receipt.add_agent(
        agent_type: agent_type,
        payment_transfer_operator_phone_numbers: payment_transfer_operator_phone_numbers,
        payment_agent_operation: payment_agent_operation,
        payment_agent_phone_numbers: payment_agent_phone_numbers,
        payment_operator_phone_numbers: payment_operator_phone_numbers,
        payment_operator_name: payment_operator_name,
        payment_operator_address: payment_operator_address,
        payment_operator_inn: payment_operator_inn,
        supplier_phone_numbers: supplier_phone_numbers
      )
    end

    it 'returns self' do
      expect(subject).to be_a(described_class)
    end
  end

  describe '#add_customer_info' do
    subject do
      receipt.add_customer_info(name: name, value: value)
    end

    it 'returns self' do
      expect(subject).to be_a(described_class)
    end
  end

  describe '#sync!' do

    subject do
      receipt.add_position(
        quantity: quantity,
        price: price,
        text: text,
        tax: tax,
        payment_method_type: payment_method_type,
        payment_subject_type: payment_subject_type,
        nomenclature_code: nomenclature_code
      ).add_payment(type: payment_type, amount: amount).add_agent(
        agent_type: agent_type,
        payment_transfer_operator_phone_numbers: payment_transfer_operator_phone_numbers,
        payment_agent_operation: payment_agent_operation,
        payment_agent_phone_numbers: payment_agent_phone_numbers,
        payment_operator_phone_numbers: payment_operator_phone_numbers,
        payment_operator_name: payment_operator_name,
        payment_operator_address: payment_operator_address,
        payment_operator_inn: payment_operator_inn,
        supplier_phone_numbers: supplier_phone_numbers
      ).add_customer_info(name: name, value: value).sync!
    end

    let(:result) do
      {
        id: id,
        inn: inn,
        group: group,
        content:
          {
            type: receipt_type,
            positions: [
              {
                quantity: quantity,
                price: price,
                tax: tax,
                text: text,
                payment_method_type: payment_method_type,
                payment_subject_type: payment_subject_type,
                nomenclature_code: nomenclature_code
              }
            ],
            check_close: {
              taxation_system: taxation_system,
              payments: [
                {
                  type: payment_type,
                  amount: amount
                }
              ]
            },
            customer_contact: customer_contact,
            agent_type: agent_type,
            payment_transfer_operator_phone_numbers: payment_transfer_operator_phone_numbers,
            payment_agent_operation: payment_agent_operation,
            payment_agent_phone_numbers: payment_agent_phone_numbers,
            payment_operator_phone_numbers: payment_operator_phone_numbers,
            payment_operator_name: payment_operator_name,
            payment_operator_address: payment_operator_address,
            payment_operator_inn: payment_operator_inn,
            supplier_phone_numbers: supplier_phone_numbers,
            additional_user_attribute: {
              name: name,
              value: value
            }
          },
        key: key
      }
    end

    let(:config) { OrangeData.configuration }

    let(:request_body) do
      {
        id: id,
        inn: inn,
        group: group,
        content:
          {
            type: OrangeData.configuration.receipt_types[receipt_type],
            positions: [
              {
                quantity: quantity,
                price: price,
                tax: OrangeData.configuration.tax_types[tax],
                text: text,
                paymentMethodType: OrangeData.configuration.payment_method_types[payment_method_type],
                paymentSubjectType: OrangeData.configuration.payment_subject_types[payment_subject_type],
                nomenclatureCode: Base64.strict_encode64(nomenclature_code)
              }
            ],
            checkClose: {
              taxationSystem: OrangeData.configuration.taxation_system_types[taxation_system],
              payments: [
                {
                  type: OrangeData.configuration.payment_types[payment_type],
                  amount: amount
                }
              ]
            },
            customerContact: customer_contact,
            agentType: OrangeData.configuration.agent_types[agent_type],
            paymentTransferOperatorPhoneNumbers: payment_transfer_operator_phone_numbers,
            paymentAgentOperation: payment_agent_operation,
            paymentAgentPhoneNumbers: payment_agent_phone_numbers,
            paymentOperatorPhoneNumbers: payment_operator_phone_numbers,
            paymentOperatorName: payment_operator_name,
            paymentOperatorAddress: payment_operator_address,
            paymentOperatorINN: payment_operator_inn,
            supplierPhoneNumbers: supplier_phone_numbers,
            additionalUserAttribute: {
              name: name,
              value: value
            }
          },
        key: key
      }
    end

    let(:response_status) { 200 }
    let(:response_body) { '' }

    before do
      stub_request(:post, 'https://apip.orangedata.ru:2443/api/v2/documents/').
        with(
          body: request_body.to_json,
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Content-Type' => 'application/json',
            'User-Agent' => 'Orange Data Ruby Client 1.0',
            'X-Signature' => signature(request_body.to_json)
          }
        ).
        to_return(status: response_status, body: response_body, headers: { 'Content-Type' => 'application/json' })
    end

    it 'returns success' do
      expect(subject.success?).to eq(true)
      expect(subject.result).to eq(result)
    end

    context 'when wrong params' do
      let(:amount) { 1000 }
      let(:response_status) { 400 }
      let(:response_body) { { errors: ['Вносимая безналичной оплатой сумма больше суммы чека'] }.to_json }

      it ' returns error ' do
        expect(subject.success?).to eq(false)
        expect(subject.error).to eq(['Вносимая безналичной оплатой сумма больше суммы чека'])
      end
    end
  end
end
