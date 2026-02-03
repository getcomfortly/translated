# frozen_string_literal: true

namespace :translated do
  desc "Sync missing translations for all TranslatedTextField records"
  task sync_missing: :environment do
    count = 0
    Translated::TranslatedTextField.find_each do |field|
      if field.missing_translations?
        puts "Syncing translations for TranslatedTextField ##{field.id} (#{field.translatable_type}##{field.translatable_id})"
        field.update_translations
        count += 1
      end
    end
    puts "Done. Synced #{count} record(s)."
  end

  desc "Re-translate all TranslatedTextField records (useful after adding a new locale)"
  task sync_all: :environment do
    count = Translated::TranslatedTextField.count
    Translated::TranslatedTextField.find_each.with_index do |field, index|
      puts "[#{index + 1}/#{count}] Syncing TranslatedTextField ##{field.id} (#{field.translatable_type}##{field.translatable_id})"
      field.update_translations
    end
    puts "Done. Synced #{count} record(s)."
  end
end
