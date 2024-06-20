# frozen_string_literal: true

class IdentitySyncJob < ApplicationJob
  def perform(provider, assembly, options = {})
    Decidim::Identity.where(provider:).find_each do |identity|
      user = identity.user
      next unless user

      next if Decidim::AssemblyMember.exists?(assembly:, user:)

      Rails.logger.info "Creating assembly member for user #{user.name} in assembly #{assembly.id}"
      Decidim::AssemblyMember.create!(
        assembly:,
        user:,
        designation_date: identity.created_at,
        position: options[:position] || "other",
        position_other: options[:position_other]
      )
    end
  end
end
