# frozen_string_literal: true

module Translated
  class UpdateRichTranslationsJob < ApplicationJob
    queue_as :default

    def perform(record, attribute_name)
      record.public_send(:"generate_translations_for_#{attribute_name}")
    end
  end
end
