Gem::Specification.new do |s|
    s.name          = "tincan-api"
    s.version       = "1.0.1"
    s.date          = "2014-05-01"
    s.summary       = "Ruby gem for the TinCan Storage API"
    s.authors       = ["Charles Hollenbeck"]
    s.email         = "charles@hollenbeck.pw"
    s.files         = ["lib/tincan.rb"]
    s.add_runtime_dependency "httparty"
    s.add_runtime_dependency "json"
    s.homepage      = "https://github.com/XD6Code/tincan-gem"
    s.license       = "MIT"
end