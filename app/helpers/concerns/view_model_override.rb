# frozen_string_literal: true

module ViewModelOverride
  extend ActiveSupport::Concern

  included do
    private

    def perform_caching?
      Decidim::Env.new("DISABLE_CACHE").blank? && cache_hash.present?
    end

    def cache_expiry_time
      Decidim::Env.new("CACHE_EXPIRY_TIME").presence&.to_i || 1.hour
    end 
  end
end