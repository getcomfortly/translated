# frozen_string_literal: true

namespace :translated do
  desc "Sync missing translations for all TranslatedTextField records"
  task sync_missing: :environment do
    puts "Syncing records with missing translations..."
    Translated::TranslatedTextField.sync_missing
    puts "Done."
  end

  desc "Re-translate all TranslatedTextField records (useful after adding a new locale)"
  task sync_all: :environment do
    puts "Syncing all #{Translated::TranslatedTextField.count} record(s)..."
    Translated::TranslatedTextField.sync_all
    puts "Done."
  end
end
