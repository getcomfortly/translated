# frozen_string_literal: true

class Article < ApplicationRecord
  has_translated_text_field :title
end
