# frozen_string_literal: true

Rails.application.config.to_prepare do
  Decidim::Assemblies::AssemblyMembersController.include(AssemblyMembersControllerOverride)
end
