# frozen_string_literal: true

require "omniauth-oauth2"
require "open-uri"

module OmniAuth
  module Strategies
    class Wpoauth < OmniAuth::Strategies::OAuth2
      # constructor arguments after `app`, the first argument, that should be a RackApp
      args [:client_id, :client_secret, :site]

      option :name, :wpoauth
      option :site, nil
      option :client_options, {}

      uid do
        raw_info["id"]
      end

      info do
        {
          email: raw_info["user_email"],
          nickname: Decidim::UserBaseEntity.nicknamize(raw_info["user_login"].presence || raw_info["user_nicename"].presence || raw_info["user_email"]),
          name: raw_info["display_name"],
          image: "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(raw_info["user_email"])}"
        }
      end

      def client
        options.client_options[:site] = options.site
        options.client_options[:authorize_url] = URI.join(options.site, "/oauth/authorize").to_s
        options.client_options[:token_url] = URI.join(options.site, "/oauth/token").to_s
        super
      end

      def raw_info
        @raw_info ||= access_token.get("/oauth/me").parsed
      end

      def callback_url
        full_host + callback_path
      end

      def sanitized_nickname
        # TODO: restrict nicknamize to the current organization
      end
    end
  end
end
