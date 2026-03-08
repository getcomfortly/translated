# frozen_string_literal: true

# This migration comes from translated (originally 202405031152)
class CreateTranslatedTranslatedTextFields < ActiveRecord::Migration[7.1]
  def change
    create_table :translated_translated_text_fields do |t|
      t.references :translatable, polymorphic: true, null: false
      t.string :field
      t.string :language
      t.text :content

      t.timestamps
    end
  end
end
