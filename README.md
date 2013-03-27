# OmniAuth Gimmebar

The unofficial OmniAuth strategy for authenticating with Gimmebar as an OAuth2 provider.

To make use of this strategy, you will need to [register your application](https://gimmebar.com/apps)

## Usage

    $ gem install omniauth-gimmebar

    use OmniAuth::Builder do
      provider :gimmebar, ENV['GIMMEBAR_CLIENT_ID'], ENV['GIMMEBAR_SECRET'], :callback_url => "http://example.com/auth/gimmebar/callback"
    end

Note that the callback URL, whether you specify it or not, *must* match the one registered to your application in Gimmebar. You will get a 500 error if it does not.

## License

This library is available under the MIT license. See LICENSE.txt for the full license.
