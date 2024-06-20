# frozen_string_literal: true

module AssemblyMembersControllerOverride
  extend ActiveSupport::Concern

  included do
    include Decidim::Paginable

    helper_method :paginated_collection

    Decidim::Paginable::OPTIONS = [21, 48, 99].freeze

    private

    def paginated_collection
      @paginated_collection ||= paginate(collection)
    end
  end
end
