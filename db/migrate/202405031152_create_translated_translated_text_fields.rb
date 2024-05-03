class CreateTranslatedTranslatedTextFields < ActiveRecord::Migration[7.2]
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
