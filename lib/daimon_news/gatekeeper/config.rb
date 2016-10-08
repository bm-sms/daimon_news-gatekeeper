require 'active_support/configurable'

module DaimonNews
  module Gatekeeper

    def self.configure(&block)
      yield @config ||= DaimonNews::Gatekeeper::Configuration.new
    end

    def self.config
      @config
    end

    class Configuration
      include ActiveSupport::Configurable
      config_accessor :sign_in_url
      config_accessor :sign_in_status_url
      config_accessor :member_only_keyword
      config_accessor :parameter_name_to_return
      config_accessor :loading_message
    end

    configure do |config|
      config.member_only_keyword = '(members only)'
      config.sign_in_status_url = 'https://example.com/'
      config.sign_in_url = nil
      config.parameter_name_to_return = 'return_to'
      config.loading_message = 'Now Loading..'
    end

  end
end
