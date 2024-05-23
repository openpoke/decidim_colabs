# frozen_string_literal: true

require "rails_helper"

describe "Homepage" do
  let!(:organization) { create(:organization) }

  before do
    organization.update(
      twitter_handler: "twitter_handler",
      facebook_handler: "facebook_handler",
      youtube_handler: "youtube_handler",
      github_handler: "github_handler"
    )

    switch_to_host(organization.host)
    visit decidim.root_path
  end

  it "includes the platform name in the footer" do
    expect(page).to have_content("Decidim")
  end

  it "includes the links to social networks" do
    expect(page).to have_xpath("//a[@href = 'https://twitter.com/twitter_handler']")
    expect(page).to have_xpath("//a[@href = 'https://www.facebook.com/facebook_handler']")
    expect(page).to have_xpath("//a[@href = 'https://www.youtube.com/youtube_handler']")
    expect(page).to have_xpath("//a[@href = 'https://www.github.com/github_handler']")
  end

  it "includes the partner logos" do
    expect(page).to have_content("Catalunya")
    expect(page).to have_content("The operations of this project are co-financed with")
  end

  it "displays the footer content correctly" do
    within ".main-footer__middle" do
      expect(page).to have_css(".border-t.mx-auto.mb-8", count: 2)
    end
  end
end
