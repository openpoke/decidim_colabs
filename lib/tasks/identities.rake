# frozen_string_literal: true

namespace :colabs do
  namespace :identity do
    desc "Syncronize users with an identity provider as members of an assembly"
    task sync: [:environment] do
      provider = Rails.application.secrets.colabs.dig(:identity_user_sync, :provider)
      assembly_slug = Rails.application.secrets.colabs.dig(:identity_user_sync, :assembly_slug)
      options = Rails.application.secrets.colabs.dig(:identity_user_sync, :options) || {}
      assembly = Decidim::Assembly.find_by(slug: assembly_slug)
      if provider.blank? || assembly.blank?
        puts "Please configure the identity_user_sync provider and assembly_slug in secrets.yml"
        puts "You can use the ENV variables like:"
        puts
        puts "IDENTITY_SYNC_ASSEMBLY_SLUG=my-assembly"
        puts "IDENTITY_SYNC_PROVIDER=wpoauth"
        exit 1
      end
      puts "Identity provider: #{provider}"
      puts "Assembly slug: #{assembly_slug}"

      Rails.logger.level = :info
      Rails.logger.extend(ActiveSupport::Logger.broadcast(Logger.new($stdout)))

      IdentitySyncJob.perform_now(provider, assembly, options)
    end
  end
end
