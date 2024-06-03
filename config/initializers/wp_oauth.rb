# frozen_string_literal: true

require "omniauth/strategies/wpoauth"

omniauth = Rails.application.secrets[:omniauth][:wpoauth]
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :wpoauth,
           setup: lambda { |env|
             request = Rack::Request.new(env)
             organization = Decidim::Organization.find_by(host: request.host)
             provider_config = organization.omniauth_settings&.filter_map do |key, value|
               next unless key.start_with?("omniauth_settings_wpoauth")

               attribute = Decidim::OmniauthProvider.extract_setting_key(key, "wp_oauth")
               [attribute, value.presence ? Decidim::AttributeEncryptor.decrypt(value) : omniauth[attribute]]
             end.to_h

             omniauth.each do |key, value|
               env["omniauth.strategy"].options[key] = provider_config[key].presence || value
             end
           }
end
