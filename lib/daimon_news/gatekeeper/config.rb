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
    end

    configure do |config|
      config.member_only_keyword = '(会員限定記事)'
      config.sign_in_status_url = nil
      config.sign_in_url = nil
    end

  end
end
