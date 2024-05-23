# frozen_string_literal: true

require "rails_helper"

describe "Admin" do
  context "when admin access to dashboard" do
    let(:organization) { create(:organization) }
    let!(:user) { create(:user, :confirmed, organization:) }
    let!(:admin) { create(:user, :admin, :confirmed, organization:) }

    before do
      switch_to_host(organization.host)
      login_as admin, scope: :user

      visit decidim_admin.root_path
    end

    it "displays decidim-awesome-module in the admin menu" do
      expect(page).to have_content("Decidim awesome")
    end
  end
end
