# frozen_string_literal: true
# This migration comes from decidim (originally 20170306144354)

class AddSecondaryHostsToOrganizations < ActiveRecord::Migration[5.0]
  def change
    add_column :decidim_organizations, :secondary_hosts, :string, array: true, default: []
    add_index :decidim_organizations, :secondary_hosts
  end
end
