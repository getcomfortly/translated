# frozen_string_literal: true

require 'rest-client'

module Translated
  class Translator
    API_HOST = ENV.fetch('TRANSLATED_API_HOST', 'https://translatedrb.com')

    def translate(text, from:, to:)
      response = RestClient.post(
        "#{API_HOST}/translate",
        { text: text, from: from, to: to }.to_json,
        accept: :json,
        authorization: "Token token=\"#{api_key}\"",
        content_type: :json
      )
      JSON.parse(response.body)['translated_text']
    end

    private

    def api_key
      fail 'Translated API key is required' if Translated.api_key.blank?

      Translated.api_key
    end
  end
end
