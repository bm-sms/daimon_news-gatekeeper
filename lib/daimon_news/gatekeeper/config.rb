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
      config_accessor :indicator_type
    end

    configure do |config|
      config.member_only_keyword = '(members only)'
      config.sign_in_status_url = ''
      config.sign_in_url = ''
      config.parameter_name_to_return = 'return_to'
      config.loading_message = 'Now Loading..'
      config.indicator_type = 'spinner-loader'
    end

  end
end
