# frozen_string_literal: true

require 'rails/engine'

module Translated
  class Engine < Rails::Engine
    isolate_namespace Translated
    config.autoload_once_paths = %W(
      #{root}/app/jobs
      #{root}/app/models
      #{root}/app/models/concerns
    )

    initializer 'translated.translatable' do
      ActiveSupport.on_load :active_record do
        include Translated::Translatable
      end
    end
  end
end
