# frozen_string_literal: true

Decidim::Calendar.configure do |config|
  # Colors per type of event
  # You can generate a nice color palette here: https://coolors.co
  # Just remove any event type that you don't want in your calendar
  config.events = {
    "Decidim::ParticipatoryProcessStep" => {
      color: "#140676",
      fontColor: "#fff", # used when "color" is used as background
      id: :participatory_step
    },
    "Decidim::Meetings::Meeting" => {
      color: "#0184C0",
      fontColor: "#fff",
      id: :meeting
    },
    "Decidim::Calendar::ExternalEvent" => {
      color: "#4EB051",
      fontColor: "#fff",
      id: :external_event
    },
    "Decidim::Debates::Debate" => {
      color: "#FDC100",
      fontColor: "#fff",
      id: :debate
    }
  }
end
