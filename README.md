[![Gem Version](http://img.shields.io/gem/v/tincan-api.svg?style=flat)][gem]
[![Code Climate Score](http://img.shields.io/codeclimate/github/XD6Code/tincan-gem.svg?style=flat)][Code CLimate]
[![License](http://img.shields.io/badge/License-MIT-yellow.svg?style=flat)][license]


# [TinCan Storage API][tincan] Gem

## Installation
#### From Ruby Gems
```
gem install tincan-api
```
#### From Github
```
git clone https://github.com/XD6Code/tincan-gem.git
cd tincan-gem
gem build tincan-api.gemspec
gem install tincan-api-*.gem
```

## Usage
Demo queries can be found on the [TinCan Storage API demo page][tincan], however in the ruby gem they can be inputted as a [Hash][ruby-hash] or [JSON][json].

**Example Query (Hash):** ```{:query => {:key => "value"}, :options => {:count => true}}```
**Example Query (JSON):** ```'{"key" => "value"}'```

```ruby
require "tincan"

demo = TinCan.new("APP_ID", "APP_KEY", "APP_NAME")

demo.validate      #=> Returns True or an Error
demo.insert(query) #=> Returns true if successful
demo.find(query)   #=> Returns data if successful
demo.update(query) #=> Returns true if successful
demo.remove(query) #=> returns true if successful
```

[tincan]:       http://apps.tincan.me/
[ruby-hash]:    http://www.ruby-doc.org/core-2.1.1/Hash.html
[json]:         http://www.json.org/

[gem]:          https://rubygems.org/gems/tincan-api
[Code CLimate]: https://codeclimate.com/github/XD6Code/tincan-gem
[license]:      https://github.com/XD6Code/tincan-gem/blob/master/LICENSE