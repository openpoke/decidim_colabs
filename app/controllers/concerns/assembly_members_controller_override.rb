# frozen_string_literal: true

module AssemblyMembersControllerOverride
  extend ActiveSupport::Concern

  included do
    include Decidim::Paginable

    Decidim::Paginable::OPTIONS = [21, 48, 99].freeze

    private

    def members
      @members ||= paginate(current_participatory_space.members.not_ceased)
    end
  end
end
