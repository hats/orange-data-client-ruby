# frozen_string_literal: true

RSpec.describe OrangeData::Configuration do
  describe '#api_url' do
    let(:url) { 'https://api.orangedata.ru:12003' }

    it "default value is 'https://api.orangedata.ru:12003'" do
      expect(described_class.new.api_url).to eq(url)
    end
  end

  describe '#api_url=' do
    let(:new_url) { 'https://api.orangedata.ru:2443' }

    it 'can set value' do
      described_class.new.yield_self do |config|
        config.api_url = new_url
        expect(config.api_url).to eq(new_url)
      end
    end
  end

  describe '#api_key' do
    it 'default value is nil' do
      expect(described_class.new.api_key).to eq(nil)
    end
  end

  describe '#api_key=' do
    let(:new_key) { '1234567' }

    it 'can set value' do
      described_class.new.yield_self do |config|
        config.api_key = new_key
        expect(config.api_key).to eq(new_key)
      end
    end
  end

  describe '#api_path' do
    it 'default value is /api/v2' do
      expect(described_class.new.api_path).to eq('/api/v2')
    end
  end

  describe '#api_path=' do
    let(:new_path) { '/api/v3' }

    it 'can set value' do
      described_class.new.yield_self do |config|
        config.api_path = new_path
        expect(config.api_path).to eq(new_path)
      end
    end
  end

  describe '#debug' do
    it 'default value is false' do
      expect(described_class.new.debug).to eq(false)
    end
  end

  describe '#debug=' do
    let(:new_value) { true }

    it 'can set value' do
      described_class.new.yield_self do |config|
        config.debug = new_value
        expect(config.debug).to eq(new_value)
      end
    end
  end

  %i(
    inn
    agent_type
    payment_agent_operation
    payment_operator_name
    payment_operator_address
    payment_operator_inn
    additional_user_attribute
    automat_number
    settlement_address
    settlement_place
    taxation_system
    receipt_type
    tax
    payment_method_type
    payment_subject_type).each do |attr|

    describe "##{attr}" do
      it 'default value is nil' do
        expect(described_class.new.public_send(attr)).to eq(nil)
      end
    end

    describe "##{attr}=" do
      let(:new_value) { '1234567' }

      it 'can set value' do
        described_class.new.yield_self do |config|
          config.public_send(:"#{attr}=", new_value)
          expect(config.public_send(attr)).to eq(new_value)
        end
      end
    end
  end

  %i(
    payment_transfer_operator_phone_numbers
    payment_agent_phone_numbers
    payment_operator_phone_numbers
    supplier_phone_numbers).each do |attr|

    describe "##{attr}" do
      it 'default value is []' do
        expect(described_class.new.public_send(attr)).to eq([])
      end
    end

    describe "##{attr}=" do
      let(:new_value) { '1234567' }

      it 'can set value' do
        described_class.new.yield_self do |config|
          config.public_send(:"#{attr}=", new_value)
          expect(config.public_send(attr)).to eq(new_value)
        end
      end
    end
  end

  describe '#group' do
    it 'default value is Main' do
      expect(described_class.new.group).to eq('Main')
    end
  end

  describe '#group=' do
    let(:new_group) { '1234567' }

    it 'can set value' do
      described_class.new.yield_self do |config|
        config.group = new_group
        expect(config.group).to eq(new_group)
      end
    end
  end

  describe '#receipt_types' do
    it 'default value is hash' do
      expect(described_class.new.receipt_types).to eq({
                                                        income: 1,
                                                        return_income: 2,
                                                        expenditure: 3,
                                                        return_expense: 4
                                                      })
    end
  end

  describe '#agent_types' do
    it 'default value is hash' do
      expect(described_class.new.agent_types).to eq({
                                                      bank_payment_agent: 0,
                                                      bank_payment_subagent: 1,
                                                      payment_agent: 2,
                                                      payment_subagent: 3,
                                                      attorney: 4,
                                                      commission_agent: 5,
                                                      other_agent: 6
                                                    })
    end
  end

  describe '#tax_types' do
    it 'default value is hash' do
      expect(described_class.new.tax_types).to eq({
                                                    vat_18: 1,
                                                    vat_10: 2,
                                                    vat_18_118: 3,
                                                    vat_10_110: 4,
                                                    vat_0: 5,
                                                    vat_not_charged: 6
                                                  })
    end
  end

  describe '#payment_method_types' do
    it 'default value is hash' do
      expect(described_class.new.payment_method_types).to eq({
                                                               full_prepayment: 1,
                                                               partial_prepayment: 2,
                                                               advance_payment: 3,
                                                               full_calculation: 4,
                                                               partial_calculation_and_credit: 5,
                                                               transfer_on_credit: 6,
                                                               credit_payment: 7
                                                             })
    end
  end

  describe '#payment_subject_types' do
    it 'default value is hash' do
      expect(described_class.new.payment_subject_types).to eq({
                                                                goods: 1,
                                                                excisable_goods: 2,
                                                                work: 3,
                                                                service: 4,
                                                                gambling_bet: 5,
                                                                gambling_winning: 6,
                                                                lottery_ticket: 7,
                                                                lottery_winning: 8,
                                                                provision_rid: 9,
                                                                payment: 10,
                                                                agenct_commission: 11,
                                                                compound_calculation: 12,
                                                                other: 13
                                                              })
    end
  end

  describe '#taxation_system_types' do
    it 'default value is hash' do
      expect(described_class.new.taxation_system_types).to eq({
                                                                osn: 0,
                                                                usn: 1,
                                                                usn_revenue_minus_consumption: 2,
                                                                envd: 3,
                                                                esn: 4,
                                                                patent: 5
                                                              })
    end
  end

  describe '#payment_types' do
    it 'default value is hash' do
      expect(described_class.new.payment_types).to eq({
                                                        cash: 1,
                                                        card: 2,
                                                        prepayment: 14,
                                                        postpayment: 15,
                                                        counterclaims: 16
                                                      })
    end
  end

  describe '#orange_data_certificate' do
    it 'default value is nil' do
      expect(described_class.new.orange_data_certificate).to eq(nil)
    end
  end

  describe '#orange_data_certificate=' do
    context 'when wrong certificate string' do
      let(:new_orange_data_certificate) do
        'test string'
      end

      it 'raise error' do
        described_class.new.yield_self do |config|
          expect { config.orange_data_certificate = new_orange_data_certificate }.to raise_exception(OpenSSL::X509::CertificateError)
        end
      end
    end

    context 'when right certificate string' do
      let(:new_orange_data_certificate) do
        <<KEY
-----BEGIN CERTIFICATE-----
MIIDYjCCAkoCAQAwDQYJKoZIhvcNAQELBQAwcTELMAkGA1UEBhMCUlUxDzANBgNV
BAgMBk1vc2NvdzEPMA0GA1UEBwwGTW9zY293MRMwEQYDVQQKDApPcmFuZ2VkYXRh
MQ8wDQYDVQQLDAZOZWJ1bGExGjAYBgNVBAMMEXd3dy5vcmFuZ2VkYXRhLnJ1MB4X
DTE4MDMxNTE2NDYwMVoXDTI4MDMxMjE2NDYwMVowfTELMAkGA1UEBhMCUlUxDzAN
BgNVBAgMBk1vc2NvdzEPMA0GA1UEBwwGTW9zY293MR8wHQYDVQQKDBZPcmFuZ2Vk
YXRhIHRlc3QgY2xpZW50MRMwEQYDVQQLDApFLWNvbW1lcmNlMRYwFAYDVQQDDA1v
cmFuZ2VkYXRhLnJ1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAo7XZ
+VUUo9p+Q0zPmlt1eThA8NmVVAgNXkVDZoz3umyEnnm2d4R5Voxf4y6fuesW3Za8
/ImKWLbQ3/S/pHZKWiz75ElSfpnYJfMRuLAaqqs0eFfxmHbHi8Mgg9zjAMdILpR6
eEaP7qeCNRom3Zb6ziYoWEmDC2ZFFu9995rjkn7CtV3noWZveOCGExjM7WTkql8L
v1PX3ee3fXaEC7Kefxl4O/4w7agEceKRHlc0l3iwVJaKittQwAQd3ieUwoqsxzPH
dRwB4IU9aI6IjfqteyD51s7xd+ayM/O4j+aJ/HBhJajDHBcGWKytxv0f6YpqPUAc
25fRAXVa0Gsei6eY/QIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCv/Vcxh2lMt8RV
Al0V9xIst0ZdjH22yTOUCOiH9PZgeagqrjTLT3ycWAdbZZUpzcFSdOmPUsgQ7Eqz
+TpcY5lmYFInLwJK/Afjqsb5LK2irGKT254p5qzD9rSRlM42wxRzQTA0BWX3mmhi
zwdrfLAvyCw1gHBbUZNf3eemBCY+8RRGPRAqD2XbyIya1bX0AHLXbx5dBe9EIOG/
F46WbTlrkR7kc06eiacTiGYwNdcywJ2KOcvmnXPup8Os6KOWe197CIathDHeiG2C
mQlsQDF/d7W4G/+l6Q66BhfRtuhp99gkT8P8j82X6ChrwbgQ5+vya3SytJ0wmIg2
67jOKmGK
-----END CERTIFICATE-----
KEY
      end

      it 'can set value' do
        described_class.new.yield_self do |config|
          config.orange_data_certificate = new_orange_data_certificate
          expect(config.orange_data_certificate).to eq(OpenSSL::X509::Certificate.new(new_orange_data_certificate))
        end
      end
    end
  end

  describe '#organization_key' do
    it 'default value is nil' do
      expect(described_class.new.organization_key).to eq(nil)
    end
  end

  describe '#organization_key=' do
    context 'when wrong key string' do
      let(:new_organization_key) do
        'test string'
      end

      it 'raise error' do
        described_class.new.yield_self do |config|
          expect { config.organization_key = new_organization_key }.to raise_exception(OpenSSL::PKey::RSAError)
        end
      end
    end

    context 'when right key string' do
      let(:new_organization_key) do
        <<KEY
-----BEGIN RSA PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC3ycL8S2HxRptB
te7yl2uje/s2pRqdXxj6D3ZiBPvPXGqQEtEddnWC6aXc/GuqM1f0C86a7xH6poo7
Id8lbQ9xEMvMKghRwc0DCkM78TmPpYBosi/uACNO3Kv2QkH2t8lqlqtWIk1m7dFJ
RgZO9XOc6Zcx/stM5MxHoc//kfVM/mfWDj4FsuYL0SGNR/Z40WrBkGo+3PJsFvqN
ocFFonRd0TeWHY54T384XQG0vCJg8MqxVPEh6Rs1/uX8NETL5htQ7FAtx54deu9t
guIZZ5w/RrsKocaP1k1jWglOErcDCtJ3jIdr1afH8ZplQ21a53UFo/2DexVf6xFX
3G2cj3p3AgMBAAECggEAPUfM+Aq6kZSVWAetsL3EajKAxOuwQCDhVx+ovW4j+DQ8
Y+WiTEyfShNV9qVD0PBltz3omch1GjpFhQn6OaRvraeIDH9HXttb3FOjr2zzYG4y
rrYbPSRWoYj63ZWiIP2O7zdl0caGQHezfNcYa2N0NTG99DGc3/q6EnhlvjWQsSbi
EjmxcPx8fmV1i4DoflMQ383nsixAFapgrROUAtCgMvhWn1kSeoojKd+e4eKZxa/S
NYulsBJWNFkmo1CZH4YTqlPM+IwYeDUOnOUGNxGurRZ3qQdWs2N2ZQhnrvlh+zpz
urD2hwAz6gQXP7mxxMR1xHtAD8XQ+w4OiJK6VWjoIQKBgQDdZJvvZrV6tvqNwuTJ
kDZjbVU0iKkbP61rVE/6JpyzfGeS0WzGBNiCpbK3pJZnatK2nS7i9v8gAfIqGAk8
1NRKLa7Qbjgw6xHEwL8VZMXzN3KsMXgGM8EziPzicCYT8VBi/kXyV0ORqRz3rMQ+
JOTkWRrcw943yYyTr84Dn0l0XQKBgQDUhFWJ3lKwOs7AlAAQqR1PjfpcRvSxVZ70
BxTwnJoIQQyPQ0/OjCc1sit5s+h8xh0MeKSilCmvZerFlgNtvsCd6geSERXbpN+k
9Vs3jAEkVeKHeUA/afmGqGCocanlarYu7uNRLfvpG7DduHBb4yJale/XGExNnwC0
N+dkUU284wKBgBaOSojQiQrQm6RXx+F1TOVCXVz102zQRwXZWDCfQHXU5eSCa7ed
BMYCxbuKDDzLGF68kutSyNlk+VwqiL5m3J4WG2pm4FizimLmVFGEq9pEuu0qORVA
rp1mhoU3cdm0S0FasJupIlwzw5zEQFYogh11qpP1bK14XlcpoS6jSuONAoGBAJqM
EljM4X1fhvPtrY5wLeyo56UrxM8h4RK+A7Bncm0GQUf+P4+JxQn7pDpBZ5U1zfI/
2hqRfS8dAvrl+WBaFGHCy/ahji/JWwrvk4J1wm7WNoMm3l4/h0MyN/jHkDJSxGKl
P5LNyiDgDmNvueZY66bM2zqlZPgd5bkp3pDJv6rZAoGAaP5e5F1j6s82Pm7dCpH3
mRZWnfZIKqoNQIq2BO8vA9/WrdFI2C27uNhxCp2ZDMulRdBZcoeHcwJjnyDzg4I4
gBZ2nSKkVdlN1REoTjLBBdlHi8XKiXzxvpItc2wjNC2AKHaJqj/dnh3bbTAQD1iU
AxPmmLJYYkhfZ2i1IrTVxZE=
-----END RSA PRIVATE KEY-----
KEY
      end

      it 'can set value' do
        described_class.new.yield_self do |config|
          config.organization_key = new_organization_key
          expect(config.organization_key).to be_a(OpenSSL::PKey::RSA)
        end
      end

      context 'and key with password' do
        let(:password) { '1234' }

        it 'can set value' do
          described_class.new.yield_self do |config|
            config.organization_key = new_organization_key, password
            expect(config.organization_key).to be_a(OpenSSL::PKey::RSA)
          end
        end
      end
    end
  end

  describe '#orange_data_key' do
    it 'default value is nil' do
      expect(described_class.new.orange_data_key).to eq(nil)
    end
  end

  describe '#orange_data_key=' do
    context 'when wrong key' do
      let(:new_orange_data_key) do
        'test string'
      end

      it 'raise error' do
        described_class.new.yield_self do |config|
          expect { config.orange_data_key = new_orange_data_key }.to raise_exception(OpenSSL::PKey::RSAError)
        end
      end

      context 'and key type' do
        let(:new_orange_data_key) do
          1234
        end

        it 'raise error' do
          described_class.new.yield_self do |config|
            expect { config.orange_data_key = new_orange_data_key }.to raise_exception(OrangeData::Configuration::WrongRSAKeyParams)
          end
        end
      end
    end

    context 'when right key string' do
      let(:new_orange_data_key) do
        <<KEY
-----BEGIN RSA PRIVATE KEY-----
MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC3ycL8S2HxRptB
te7yl2uje/s2pRqdXxj6D3ZiBPvPXGqQEtEddnWC6aXc/GuqM1f0C86a7xH6poo7
Id8lbQ9xEMvMKghRwc0DCkM78TmPpYBosi/uACNO3Kv2QkH2t8lqlqtWIk1m7dFJ
RgZO9XOc6Zcx/stM5MxHoc//kfVM/mfWDj4FsuYL0SGNR/Z40WrBkGo+3PJsFvqN
ocFFonRd0TeWHY54T384XQG0vCJg8MqxVPEh6Rs1/uX8NETL5htQ7FAtx54deu9t
guIZZ5w/RrsKocaP1k1jWglOErcDCtJ3jIdr1afH8ZplQ21a53UFo/2DexVf6xFX
3G2cj3p3AgMBAAECggEAPUfM+Aq6kZSVWAetsL3EajKAxOuwQCDhVx+ovW4j+DQ8
Y+WiTEyfShNV9qVD0PBltz3omch1GjpFhQn6OaRvraeIDH9HXttb3FOjr2zzYG4y
rrYbPSRWoYj63ZWiIP2O7zdl0caGQHezfNcYa2N0NTG99DGc3/q6EnhlvjWQsSbi
EjmxcPx8fmV1i4DoflMQ383nsixAFapgrROUAtCgMvhWn1kSeoojKd+e4eKZxa/S
NYulsBJWNFkmo1CZH4YTqlPM+IwYeDUOnOUGNxGurRZ3qQdWs2N2ZQhnrvlh+zpz
urD2hwAz6gQXP7mxxMR1xHtAD8XQ+w4OiJK6VWjoIQKBgQDdZJvvZrV6tvqNwuTJ
kDZjbVU0iKkbP61rVE/6JpyzfGeS0WzGBNiCpbK3pJZnatK2nS7i9v8gAfIqGAk8
1NRKLa7Qbjgw6xHEwL8VZMXzN3KsMXgGM8EziPzicCYT8VBi/kXyV0ORqRz3rMQ+
JOTkWRrcw943yYyTr84Dn0l0XQKBgQDUhFWJ3lKwOs7AlAAQqR1PjfpcRvSxVZ70
BxTwnJoIQQyPQ0/OjCc1sit5s+h8xh0MeKSilCmvZerFlgNtvsCd6geSERXbpN+k
9Vs3jAEkVeKHeUA/afmGqGCocanlarYu7uNRLfvpG7DduHBb4yJale/XGExNnwC0
N+dkUU284wKBgBaOSojQiQrQm6RXx+F1TOVCXVz102zQRwXZWDCfQHXU5eSCa7ed
BMYCxbuKDDzLGF68kutSyNlk+VwqiL5m3J4WG2pm4FizimLmVFGEq9pEuu0qORVA
rp1mhoU3cdm0S0FasJupIlwzw5zEQFYogh11qpP1bK14XlcpoS6jSuONAoGBAJqM
EljM4X1fhvPtrY5wLeyo56UrxM8h4RK+A7Bncm0GQUf+P4+JxQn7pDpBZ5U1zfI/
2hqRfS8dAvrl+WBaFGHCy/ahji/JWwrvk4J1wm7WNoMm3l4/h0MyN/jHkDJSxGKl
P5LNyiDgDmNvueZY66bM2zqlZPgd5bkp3pDJv6rZAoGAaP5e5F1j6s82Pm7dCpH3
mRZWnfZIKqoNQIq2BO8vA9/WrdFI2C27uNhxCp2ZDMulRdBZcoeHcwJjnyDzg4I4
gBZ2nSKkVdlN1REoTjLBBdlHi8XKiXzxvpItc2wjNC2AKHaJqj/dnh3bbTAQD1iU
AxPmmLJYYkhfZ2i1IrTVxZE=
-----END RSA PRIVATE KEY-----
KEY
      end

      it 'can set value' do
        described_class.new.yield_self do |config|
          config.orange_data_key = new_orange_data_key
          expect(config.orange_data_key).to be_a(OpenSSL::PKey::RSA)
        end
      end

      context 'and key with password' do
        let(:password) { '1234' }

        it 'can set value' do
          described_class.new.yield_self do |config|
            config.orange_data_key = new_orange_data_key, password
            expect(config.orange_data_key).to be_a(OpenSSL::PKey::RSA)
          end
        end
      end
    end
  end
end
