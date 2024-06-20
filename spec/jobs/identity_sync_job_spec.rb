# frozen_string_literal: true

require "rails_helper"

describe IdentitySyncJob do
  let!(:good_users) { create_list(:user, 5, organization:) }
  let(:organization) { create(:organization) }
  let!(:assembly) { create(:assembly, organization:) }
  let!(:bad_users) { create_list(:user, 5, organization:) }

  before do
    good_users.each do |user|
      create(:identity, user:, provider: "wpoauth")
    end

    bad_users.each do |user|
      create(:identity, user:, provider: "another")
    end
  end

  it "syncronizes the users with the correct provider" do
    expect(assembly.members.count).to eq(0)

    IdentitySyncJob.perform_now("wpoauth", assembly)

    expect(assembly.members.count).to eq(5)
    expect(assembly.members.map(&:user)).to match_array(good_users)
    expect(assembly.members.pluck(:position)).to match_array(Array.new(5, "other"))
    expect(assembly.members.pluck(:position_other)).to match_array(Array.new(5, nil))
  end

  context "when options are provided" do
    it "syncronizes the users with the correct provider" do
      expect(assembly.members.count).to eq(0)

      IdentitySyncJob.perform_now("wpoauth", assembly, position: "president", position_other: "CEO")

      expect(assembly.members.count).to eq(5)
      expect(assembly.members.map(&:user)).to match_array(good_users)
      expect(assembly.members.pluck(:position)).to match_array(Array.new(5, "president"))
      expect(assembly.members.pluck(:position_other)).to match_array(Array.new(5, "CEO"))
    end
  end
end
