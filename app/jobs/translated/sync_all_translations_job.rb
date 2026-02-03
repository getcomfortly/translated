# frozen_string_literal: true

module Translated
  class SyncAllTranslationsJob < ApplicationJob
    queue_as :default

    def perform
      TranslatedTextField.sync_all
    end
  end
end
