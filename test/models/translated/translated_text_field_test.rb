# frozen_string_literal: true

require 'test_helper'

module Translated
  class TranslatedTextFieldTest < ActiveSupport::TestCase
    test 'with_missing_translations includes records missing translations' do
      article = Article.create!(title: 'Hello')

      field = TranslatedTextField.find_by(translatable: article, field: 'title')
      assert field, 'TranslatedTextField should have been created'

      missing = TranslatedTextField.with_missing_translations
      assert_includes missing, field
    end

    test 'with_missing_translations excludes fully translated records' do
      article = Article.create!(title: 'Hello')

      field = TranslatedTextField.find_by(translatable: article, field: 'title')
      field.update!(content: { 'en' => 'Hello', 'es' => 'Hola' })

      missing = TranslatedTextField.with_missing_translations
      assert_not_includes missing, field
    end
  end
end
