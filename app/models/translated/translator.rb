# frozen_string_literal: true

require 'rest-client'

module Translated
  class Translator
    API_HOST = ENV.fetch('TRANSLATOR_API_HOST', 'http://localhost:3000')

    def translate(text, from:, to:)
      response = RestClient.post(
        "#{API_HOST}/translate",
        { text: text, from: from, to: to }.to_json,
        content_type: :json,
        accept: :json
      )
      JSON.parse(response.body)['translated_text']
    end
  end
end
