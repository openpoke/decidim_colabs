# frozen_string_literal: true

require "rails_helper"

describe "Homepage" do
  let!(:organization) { create(:organization) }
  let!(:assembly) { create(:assembly, organization:) }
  # rubocop:disable FactoryBot/ExcessiveCreateList:
  let!(:members) { create_list(:assembly_member, 99, assembly:) }
  # rubocop:enable FactoryBot/ExcessiveCreateList:

  before do
    switch_to_host(organization.host)
    visit decidim_assemblies.assembly_assembly_members_path(assembly_slug: assembly.slug)
  end

  it "shows the first 21 members" do
    expect(page).to have_content("Members\n99")
    expect(page).to have_css(".profile__user", count: 21)
  end

  it "has paginator" do
    within "[data-pagination]" do
      expect(page).to have_css("li[data-page]", count: 5)
    end
  end
end
