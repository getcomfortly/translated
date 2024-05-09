# frozen_string_literal: true

require 'translated/version'
require 'translated/engine'
require 'translated/configuration'

module Translated
  @config = Configuration.new

  class << self
    extend Forwardable

    attr_reader :config

    def_delegators :@config, :api_key, :api_key=
    def_delegators :@config, :environments, :environments=
  end
end
