# frozen_string_literal: true

require "rails_helper"
require "omniauth"
require "omniauth/test"

RSpec.configure do |config|
  config.extend OmniAuth::Test::StrategyMacros, type: :strategy
end

describe OmniAuth::Strategies::Wpoauth do
  subject do
    strategy
  end

  let(:access_token) { instance_double("AccessToken", options: {}) }
  let(:parsed_response) { instance_double("ParsedResponse") }
  let(:response) { instance_double("Response", parsed: parsed_response) }
  # rubocop:enable RSpec/VerifiedDoubleReference
  let(:strategy) do
    described_class.new(
      app,
      "CLIENT_ID",
      "CLIENT_SECRET",
      "https://wpoauth.org"
    )
  end
  let(:app) do
    lambda do |_env|
      [200, {}, ["Hello."]]
    end
  end
  let(:uid) { { "id" => "123" } }
  let(:info) do
    {
      "display_name" => "Arthur W. Pendragon",
      "user_email" => "foo@example.com",
      "user_login" => "arthur"
    }
  end
  let(:raw_info_hash) do
    uid.merge(info)
  end

  before do
    allow(strategy).to receive(:access_token).and_return(access_token)
  end

  describe "client options" do
    it "has the correct name" do
      expect(subject.options.name).to eq(:wpoauth)
    end

    it "has the correct site" do
      expect(subject.client.site).to eq("https://wpoauth.org")
    end

    it "has the correct authorize url" do
      expect(subject.client.options[:authorize_url]).to eq("https://wpoauth.org/oauth/authorize")
    end

    it "has the correct token url" do
      expect(subject.client.options[:token_url]).to eq("https://wpoauth.org/oauth/token")
    end

    it "has correct authorize params" do
      # https://wpoauth.org/oauth/authorize?client_id=xxxxxx&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Fusers%2Fauth%2Fidcat_mobil%2Fcallback&response_type=code&state=2ec1a9a9db94fbce7f19ee30d682ab75f97f4fd67848773c&approval_prompt=auto&scope=autenticacio_usuari&response_type=code
      expect(subject.client.id).to eq("CLIENT_ID")
      expect(subject.client.secret).to eq("CLIENT_SECRET")
    end
  end

  describe "#callback_url" do
    it "is a combination of host, script name, and callback path" do
      allow(strategy).to receive(:full_host).and_return("https://example.com")

      expect(subject.callback_url).to eq("https://example.com/users/auth/wpoauth/callback")
    end
  end

  describe "uid" do
    before do
      allow(strategy).to receive(:raw_info).and_return(raw_info_hash)
    end

    it "returns the id" do
      expect(subject.uid).to eq(uid["id"])
    end
  end

  describe "info" do
    before do
      allow(strategy).to receive(:raw_info).and_return(raw_info_hash)
    end

    it "returns the name" do
      expect(subject.info[:name]).to eq(raw_info_hash["display_name"])
    end

    it "returns the email" do
      expect(subject.info[:email]).to eq(raw_info_hash["user_email"])
    end

    it "returns the nickname" do
      expect(subject.info[:nickname]).to eq("arthur")
    end

    context "when nickname already exists" do
      let!(:existing_user) { create(:user, nickname: "arthur") }

      it "returns a new valid nickname" do
        expect(subject.info[:nickname]).to eq("arthur_2")
      end
    end
  end
end
