# frozen_string_literal: true

source "https://rubygems.org"

ruby RUBY_VERSION

DECIDIM_VERSION = { github: "decidim/decidim", branch: "release/0.29-stable", ref: "7ba58b002231d28bbe5dbaf0105b067b70219439"}.freeze
gem "decidim", DECIDIM_VERSION
gem "decidim-conferences", DECIDIM_VERSION
gem "decidim-templates", DECIDIM_VERSION

gem "decidim-alternative_landing", github: "openpoke/decidim-module-alternative_landing", branch: "release/0.29-stable"
gem "decidim-calendar", github: "decidim-ice/decidim-module-calendar", branch: "release/0.29-stable"
gem "decidim-decidim_awesome", github: "decidim-ice/decidim-module-decidim_awesome", branch: "release/0.29-stable"
gem "decidim-term_customizer", github: "openpoke/decidim-module-term_customizer", branch: "release/0.29-stable"

gem "bootsnap", "~> 1.7"

gem "puma", ">= 6.3.1"

gem "wicked_pdf", "~> 2.1"

gem "deface", ">= 1.9"
gem "faraday"

group :development, :test do
  gem "byebug", "~> 11.0", platform: :mri

  gem "brakeman"
  gem "decidim-dev", DECIDIM_VERSION
end

group :development do
  gem "letter_opener_web"
  gem "listen"
  gem "rubocop-faker"
  gem "web-console"
end

group :production do
  gem "azure-storage-blob", require: false
  gem "sidekiq"
  gem "sidekiq-cron"
end
