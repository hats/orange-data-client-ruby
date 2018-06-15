module Signature
  def signature(payload)
    OpenSSL::Digest::SHA256.new.yield_self do |digest|
      OrangeData.configuration.organization_key.sign(digest, payload).yield_self do |raw_signature|
        Base64.strict_encode64(raw_signature)
      end
    end
  end
end

RSpec.configuration.include Signature
