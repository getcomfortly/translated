# Translated
Simple, automatic translations for your Rails app with https://translatedrb.com.

## Usage
Translated can handle both plain text and rich text (using Action Text).

These helpers will let you work with the content attribute like you normally would. The return value of this attribute will always be in the language specified by `I18n.locale`. So if it's set to `:es`, then you'll get Spanish.

When you set the value, it will save that for the current locale and then create translations for every locale listed in the `I18n.available_locales` list.

For plain text, simply add this to your model:

```ruby
class Message < ApplicationRecord
  has_translated_text_field :content
end
```

For rich text:

```ruby
class Message < ApplicationRecord
  has_translated_rich_text :content
end
```

You can use this attribute just like any other Action Text attribute.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "translated"
```

And then execute:
```bash
bundle
```

Install the migrations:
```bash
bin/rails translated:install:migrations
```

Get your API key from https://translatedrb.com

Create an initializer `config/initializers/translated.rb`
```ruby
Translated.api_key = 'API KEY from translatedrb.com'
Translated.environments = %w(development production)
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
