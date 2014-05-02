[![Gem Version](http://img.shields.io/gem/v/dword-hex-converter.svg?style=flat)][gem]
[![License](http://img.shields.io/badge/License-MIT-yellow.svg?style=flat)][license]


# [TinCan Storage API][tincan] Gem

## Installation
#### From Ruby Gems:
```
gem install tincan-api
```
#### From Github:
```
git clone https://github.com/XD6Code/tincan-gem.git
cd tincan-gem
gem build tincan-api.gemspec
gem install tincan-api-*.gem
```


## Usage
Demo queries can be found on the [TinCan Storage API demo page][tincan]

```ruby
require "tincan"

demo = TinCan.new("APP_ID", "APP_KEY", "APP_NAME")

demo.validate      #=> Returns True or an Error
demo.insert(query) #=> Returns true if successful
demo.find(query)   #=> Returns data if successful
demo.update(query) #=> Returns true if successful
demo.delete(query) #=> returns true if successful
```


[tincan]: http://apps.tincan.me/

[gem]: https://rubygems.org/gems/tincan-api
[license]: https://github.com/XD6Code/tincan-gem/blob/master/LICENSE