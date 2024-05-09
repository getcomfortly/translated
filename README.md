# Translated
Simple, automatic translations for your Rails app.

## Usage
Translated can handle both plain text and rich text (using actiontext).

These helpers will let you work with the content attribute like you normally would. The return of this attribute will always be in the language specified by I18n.current_locale. So if it's set to :es, then you'll get Spanish. When you set the value it will save that for the current_locale and then create translations for every locale listed in the I18n.available_locales list.

For plain text, simply add this to your model:

```ruby
class Message < ApplicationRecord
  has_translated_text :content
end
```

For rich text:

```ruby
class Message < ApplicationRecord
  has_translated_rich_text :content
end
```

You can use this attribute just like any other actiontext attribute.

## Installation
Add this line to your application's Gemfile:

```ruby
gem "translated"
```

And then execute:
```bash
$ bundle
```

Install the migrations:
```bash
$ bin/rails translated:install:migrations
```

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
