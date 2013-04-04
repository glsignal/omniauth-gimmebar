require 'spec_helper'

describe OmniAuth::Strategies::Gimmebar do

  subject do
    OmniAuth::Strategies::Gimmebar.new(
      "app",
      "client_id",
      "client_secret",
      {:callback_url => "fake-callback-url"}
    )
  end

  let(:sample_response) do
    {
      :request_token => '{"request_token":"fake-request-token","expires":1365050180}',
      :authorization_token => '{"code":"fake-authorization-token","expires":1365050194}',
      :access_token => '{"access_token":"fake-access-token","refresh_token":"fake-refresh-token","token_type":"bearer","expires_in":null,"user_id":"someones-uid","username":"someones-username"}'
    }
  end

  it "has the correct name" do
    subject.options.name.should eq("gimmebar")
  end

  context "endpoints" do
    it "has the correct base URL" do
      subject.options.client_options.site.should eq('https://gimmebar.com')
    end

    it "has the correct authorisation URL" do
      subject.options.client_options.authorize_url.should eq('/authorize')
    end

    it "has the correct token URL" do
      subject.options.client_options.token_url.should eq('/api/v1/auth/token/access')
    end

    it "allows the callback url to be specified" do
      subject.callback_url.should == "fake-callback-url"
    end

    context "request token" do
      it "attempts to retreive a request token from Gimmebar" do
        stub_request(:post, "https://gimmebar.com/api/v1/auth/token/request")
          .with(:body => {
            :client_id => "client_id",
            :client_secret => "client_secret",
            :type => "app"
          })
          .to_return(:body => sample_response[:request_token])

        subject.request_token.should == "fake-request-token"
      end

      it "retrieves the request token during the request phase" do
        subject.should_receive(:request_token)
        subject.request_phase
      end

      it "specifies the request token in the request phase" do
        stub_request(:post, "https://gimmebar.com/api/v1/auth/token/request")
          .to_return(:body => sample_response[:request_token])

        subject.should_receive(:redirect)
          .with("https://gimmebar.com/authorize?response_type=code&client_id=client_id&redirect_uri=fake-callback-url&token=fake-request-token")
        subject.request_phase
      end
    end
  end
end
