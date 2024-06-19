# frozen_string_literal: true

module Decidim
  module ContentBlocks
    class LinksBlocksCell < Decidim::ViewModel
      def show
        render
      end

      def url(num)
        model.settings.send("url#{num}")
      end

      def label(num)
        translated_attribute(model.settings.send("title#{num}"))
      end

      def image(num)
        return asset_pack_path("media/images/links_block#{num}.png") unless model.images_container.attached_uploader(:"image#{num}").attached?

        model.images_container.attached_uploader(:"image#{num}").path
      end
    end
  end
end
