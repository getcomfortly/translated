# frozen_string_literal: true

class ChangeTranslatedTextFieldsContentToJson < ActiveRecord::Migration[7.1]
  def up
    change_column :translated_translated_text_fields, :content, :json
  end

  def down
    change_column :translated_translated_text_fields, :content, :text
  end
end
