# frozen_string_literal: true

require_relative 'lib/translated/version'

Gem::Specification.new do |spec|
  spec.name        = 'translated'
  spec.version     = Translated::VERSION
  spec.authors     = ['Trae Robrock', 'Andrew Katz']
  spec.email       = ['trobrock@comfort.ly', 'andrew@comfort.ly']
  spec.homepage    = 'https://github.com/getcomfortly/translated'
  spec.summary     = 'Simple, automatic translations for your Rails app.'
  spec.description = 'Simple, automatic translations for your Rails app.'
  spec.license     = 'MIT'

  spec.required_ruby_version = '>= 3.0.0'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata['allowed_push_host'] = 'https://rubygems.org'

  spec.metadata['homepage_uri'] = 'https://translatedrb.com'
  spec.metadata['source_code_uri'] = 'https://github.com/getcomfortly/translated'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  end

  rails_version = '>= 7.1'
  spec.add_dependency 'activejob', rails_version
  spec.add_dependency 'activerecord', rails_version
  spec.add_dependency 'railties', rails_version
  spec.add_dependency 'activesupport', rails_version
  spec.add_dependency 'rest-client', '>= 2.1.0'

  spec.metadata['rubygems_mfa_required'] = 'true'
end
