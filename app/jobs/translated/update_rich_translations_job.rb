# frozen_string_literal: true

module Translated
  class UpdateRichTranslationsJob < ApplicationJob
    queue_as :default

    def perform(record, attribute_name, from_locale, to_locale)
      record.public_send(:"generate_translation_for_#{attribute_name}", from_locale, to_locale)
    end
  end
end
