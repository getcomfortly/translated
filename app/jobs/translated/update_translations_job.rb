# frozen_string_literal: true

module Translated
  class UpdateTranslationsJob < ApplicationJob
    queue_as :default

    def perform(translated_text_field)
      translated_text_field.update_translations
    end
  end
end
