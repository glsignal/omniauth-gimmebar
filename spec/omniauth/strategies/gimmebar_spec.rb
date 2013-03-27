require 'spec_helper'

describe OmniAuth::Strategies::Gimmebar do
  subject { OmniAuth::Strategies::Gimmebar.new("client_id", "client_secret", {}) }

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
  end
end
