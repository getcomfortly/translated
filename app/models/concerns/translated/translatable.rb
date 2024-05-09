# frozen_string_literal: true

module Translated
  module Translatable
    extend ActiveSupport::Concern

    class_methods do
      def has_translated_text_field(name, validates: {}) # rubocop:disable Naming/PredicateName
        class_eval <<-CODE, __FILE__, __LINE__ + 1 # rubocop:disable Style/DocumentDynamicEvalDefinition
        def #{name}
          translation = #{name}_translation || build_#{name}_translation
          translation&.for_locale(I18n.locale)
        end

        def #{name}?
          #{name}.present?
        end

        def #{name}=(content)
          translation = self.#{name}_translation || build_#{name}_translation
          translation.set_locale(I18n.locale, content)
          @_#{name}_translation_changed = true
          content
        end

        private

        def #{name}_translation_changed?
          defined?(:@_#{name}_translation_changed) && @_#{name}_translation_changed
        end
        CODE

        has_one :"#{name}_translation",
                -> { where(field: name.to_s) },
                class_name: 'Translated::TranslatedTextField',
                as: :translatable,
                dependent: :destroy,
                inverse_of: :translatable
        after_save -> { public_send(:"#{name}_translation").save }, if: :"#{name}_translation_changed?"

        validates name, validates if validates.present?

        scope :with_translations, -> { includes(:translated_text_fields) }
      end

      def has_translated_rich_text(name) # rubocop:disable Naming/PredicateName
        class_eval <<-CODE, __FILE__, __LINE__ + 1 # rubocop:disable Style/DocumentDynamicEvalDefinition
          def #{name}
            public_send(:"#{name}_\#{I18n.locale}")
          end

          def #{name}?
            #{name}.present?
          end

          def #{name}=(body)
            self.public_send(:"#{name}_\#{I18n.locale}=", body)

            I18n.available_locales.each do |locale|
              next if locale == I18n.locale

              generate_translation_for_#{name}(I18n.locale, locale)
            end

            body
          end

          private

          def generate_translation_for_#{name}(from, to)
            self.public_send(:"#{name}_\#{to}=", Translator.new.translate(public_send(:"#{name}_\#{from}").body.to_html, from:, to:))
          end
        CODE

        I18n.available_locales.each do |locale|
          has_rich_text :"#{name}_#{locale}"
        end

        scope :"with_rich_text_#{name}", lambda {
                                           includes(I18n.available_locales.map do |locale|
                                                      :"rich_text_#{name}_#{locale}"
                                                    end)
                                         }
        scope :"with_rich_text_#{name}_and_embeds", lambda {
                                                      includes(I18n.available_locales.to_h do |locale|
                                                                 [:"rich_text_#{name}_#{locale}",
                                                                  { embeds_attachments: :blob }]
                                                               end)
                                                    }
      end
    end
  end
end
