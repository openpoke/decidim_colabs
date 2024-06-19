# frozen_string_literal: true

Decidim.content_blocks.register(:homepage, :links_block) do |content_block|
  content_block.cell = "decidim/content_blocks/links_blocks"
  content_block.public_name_key = "decidim.content_blocks.links_blocks.name"
  content_block.settings_form_cell = "decidim/content_blocks/links_blocks_settings_form"

  content_block.settings do |settings|
    settings.attribute :title1, type: :text, translated: true
    settings.attribute :url1, type: :text
    settings.attribute :title2, type: :text, translated: true
    settings.attribute :url2, type: :text
    settings.attribute :title3, type: :text, translated: true
    settings.attribute :url3, type: :text
  end

  content_block.images = [
    {
      name: :image1,
      uploader: "Decidim::HomepageImageUploader"
    },
    {
      name: :image2,
      uploader: "Decidim::HomepageImageUploader"
    },
    {
      name: :image3,
      uploader: "Decidim::HomepageImageUploader"
    }
  ]
  content_block.default!
end
