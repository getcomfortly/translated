# frozen_string_literal: true

module Translated
  class Configuration
    attr_accessor :api_key, :environments

    def initialize
      @environments = %w(development production)
    end
  end
end
