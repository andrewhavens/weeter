require "singleton"

module Weeter

  class Configuration
    include Singleton
    attr_accessor :log_path

    autoload :ClientAppConfig, 'weeter/configuration/client_app_config'
    autoload :TwitterConfig,   'weeter/configuration/twitter_config'
    autoload :LimiterConfig,   'weeter/configuration/limiter_config'


    def twitter
      yield Configuration::TwitterConfig.instance if block_given?
      Configuration::TwitterConfig.instance
    end

    def limiter
      yield Configuration::LimiterConfig.instance if block_given?
      Configuration::LimiterConfig.instance
    end

    def client_app
      @client_app_config ||= Configuration::ClientAppConfig.new
      yield @client_app_config if block_given?
      @client_app_config
    end
  end
end
