# frozen_string_literal: true

RSpec.describe OrangeData do
  it 'has a version number' do
    expect(described_class::VERSION).not_to be nil
  end

  describe '#configure' do
    let(:url) { 'https://apip.orangedata.ru:2443' }
    before do
      described_class.configure do |config|
        config.api_url = url
      end
    end

    it 'returns api url' do
      expect(described_class::Client.new.api_url).to eq(url)
    end
  end

  describe '.reset' do
    let(:url) { 'https://apip.orangedata.ru:2443' }
    let(:default_url) { 'https://api.orangedata.ru:12003' }

    before :each do
      described_class.configure do |config|
        config.api_url = url
      end
    end

    it 'resets the configuration' do
      described_class.reset

      expect(described_class.configuration.api_url).to eq(default_url)
    end
  end
end
