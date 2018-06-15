# frozen_string_literal: true

require 'base64'
require 'securerandom'

require 'orange_data/version'
require 'orange_data/pipeline_mixin'
require 'orange_data/configuration'
require 'orange_data/client'
require 'orange_data/receipt'
require 'orange_data/receipt_status'

module OrangeData
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
