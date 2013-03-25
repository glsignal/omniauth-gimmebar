# OmniAuth Gimmebar

The unofficial OmniAuth strategy for authenticating with Gimmebar as an OAuth2 provider.

To make use of this strategy, you will need to [register your application](https://gimmebar.com/apps)

## Usage

> $ gem install omniauth-gimmebar

> use OmniAuth::Builder do
>   provider :gimmebar, ENV['GIMMEBAR_CLIENT_ID'], ENV['GIMMEBAR_SECRET']
> end

## Ruby

This has been tested with the following versions of the Ruby interpreter:

- Ruby 1.9.3 (MRI)

## License

This library is available under the MIT license. See LICENSE.txt for the full license.
