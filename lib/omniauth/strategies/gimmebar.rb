require 'omniauth-oauth2'
require 'rest-client'
require 'multi_json'

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

      uid { raw_info["id"] }

      info do
        {
          'email' => raw_info["email"],
          'name' => raw_info["name"]
        }
      end

      extra do
        { :raw_info => raw_info }
      end

      def request_phase
        redirect client.auth_code.authorize_url({
          :redirect_uri => callback_url,
          :token => request_token
        }.merge(options.authorize_params))
      end

      def request_token
        # We need to get a request token before redirecting the user
        response = RestClient.post(
          "https://gimmebar.com/api/v1/auth/token/request",
          :client_id => client.id,
          :client_secret => client.secret,
          :type => 'app'
        )
        MultiJson.load(response)["request_token"]
      end

      def callback_url
        @callback || super
      end

      def raw_info
        @raw_info ||= access_token.get(
          "https://gimmebar.com/api/v1/user/#{access_token.params["user_id"]}?_extension[]=authed_user",
        ).parsed
      end
    end
  end
end
