Gem::Specification.new do |s|
  s.name        = 'foostix-api-client'
  s.version     = '1.1.0'
  s.date        = '2019-03-25'
  s.summary     = "Foostix Api Client Gem"
  s.description = "Gem for Foostix Api"
  s.authors     = ["Stephen Edwards"]
  s.email       = 'stephen.edwards@foostix.com'
  s.files       = ["lib/foostix-api-client.rb"]
  s.homepage    =
    'https://www.foostix.com'
  s.license       = 'MIT'

  s.add_runtime_dependency 'rest-client', '>= 1.8'
  s.add_runtime_dependency 'json', '>= 1.7.0'
end
