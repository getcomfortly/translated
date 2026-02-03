# frozen_string_literal: true

module Translated
  class TranslatedTextField < ApplicationRecord
    serialize :content, coder: JSON

    belongs_to :translatable, polymorphic: true

    validates :language, presence: true, inclusion: { in: I18n.available_locales.map(&:to_s) }

    scope :with_missing_translations, -> {
      where.not(id: where("json_array_length(content) >= ?", I18n.available_locales.size))
    }

    after_commit :update_translations_later, if: :needs_translations?

    after_initialize do
      self.content ||= {}
    end

    def for_locale(locale)
      content.fetch(locale.to_s) { content[language] }
    end

    def missing_translations?
      (I18n.available_locales.map(&:to_s) - content.keys).any?
    end

    def set_locale(locale, value)
      locale = locale.to_s
      self.language = locale

      self.content ||= {}
      self.content[locale] = value

      @_needs_translations = content_changed?
      value
    end

    def update_translations
      source = content[language]

      I18n.available_locales.each do |locale|
        next if locale == language.to_sym

        content[locale.to_s] = source.presence && Translator.new.translate(source, from: language, to: locale.to_s)
      end

      save!
    end

    private

    def needs_translations?
      defined?(:@_needs_translations) && @_needs_translations && Translated.environments.include?(Rails.env)
    end

    def update_translations_later
      UpdateTranslationsJob.perform_later(self)
    end
  end
end
