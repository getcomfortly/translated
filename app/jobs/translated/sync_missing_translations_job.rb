# frozen_string_literal: true

module Translated
  class SyncMissingTranslationsJob < ApplicationJob
    queue_as :default

    def perform
      TranslatedTextField.sync_missing
    end
  end
end
