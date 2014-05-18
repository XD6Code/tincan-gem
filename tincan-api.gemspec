Gem::Specification.new do |s|
    s.name          = "tincan-api"
    s.version       = "1.2.2"
    s.date          = "2014-05-17"
    s.summary       = "Ruby gem for the TinCan Storage API"
    s.authors       = ["Charles Hollenbeck"]
    s.email         = "charles@hollenbeck.pw"
    s.files         = ["lib/tincan.rb", "lib/ssl/tincan.crt"]
    s.add_runtime_dependency "httparty"
    s.add_runtime_dependency "json"
    s.homepage      = "https://github.com/XD6Code/tincan-gem"
    s.license       = "MIT"
end