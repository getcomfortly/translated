# frozen_string_literal: true

module Translated
  class UpdateTranslationsJob < ApplicationJob
    queue_as :default
    retry_on RestClient::BadGateway, wait: :polynomially_longer, attempts: 5

    def perform(translated_text_field)
      translated_text_field.update_translations
    end
  end
end
