require 'omniauth-oauth2'
require 'rest-client'
require 'json'

module OmniAuth
  module Strategies
    class Gimmebar < OmniAuth::Strategies::OAuth2
      def initialize(app, client_id, client_secret, options = {})
        @callback = options.fetch(:callback_url, nil)
        super(app, client_id, client_secret, options)
      end

      option :client_options, {
        :site           => 'https://gimmebar.com',
        :authorize_url  => '/authorize',
        :token_url      => '/api/v1/auth/token/access'
      }

      option :provider_ignores_state, true

      option :uid_field, "user_id"

      uid { request.params[options.uid_field.to_s] }

      def request_phase
        redirect client.auth_code.authorize_url({
          :redirect_uri => callback_url,
          :token => request_token
        }.merge(options.authorize_params))
      end

      def request_token
        # We need to get a request token before redirect the user
        response = RestClient.post(
          "https://gimmebar.com/api/v1/auth/token/request",
          :client_id => client.id,
          :client_secret => client.secret,
          :type => 'app'
        )
        JSON.parse(response)["request_token"]
      end

      def callback_url
        @callback || super
      end
    end
  end
end
