require 'active_support/configurable'

module DaimonNews
  module Gatekeeper

    CONFIG_PROPERTIES = {
        sign_in_url: '',
        sign_in_status_url: '',
        member_only_keyword: '(members only)',
        parameter_name_to_return: 'return_to',
        loading_message: 'Now Loading..',
        indicator_type: 'spinner-loader'
    }

    def self.configure(&block)
      yield @config ||= DaimonNews::Gatekeeper::Configuration.new
    end

    def self.config
      @config
    end

    def self.define_sprockets_dependency
      Rails.application.configure do
        config.assets.configure do |env|
          env.register_dependency_resolver 'daimon-news-gatekeeper-config' do
            DaimonNews::Gatekeeper::CONFIG_PROPERTIES.keys.map do |p|
              DaimonNews::Gatekeeper.config.send(p)
            end
          end
          env.depend_on 'daimon-news-gatekeeper-config'
        end
      end
    end

    class Configuration
      include ActiveSupport::Configurable
      DaimonNews::Gatekeeper::CONFIG_PROPERTIES.keys.each do |p|
        config_accessor p
      end
    end

    configure do |config|
      props = DaimonNews::Gatekeeper::CONFIG_PROPERTIES
      props.keys.each do |p|
        config.send("#{p}=", props[p])
      end
    end

  end
end
