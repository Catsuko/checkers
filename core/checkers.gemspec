Gem::Specification.new do |s|
  s.name      = 'checkers'
  s.authors     = 'Lewis Reid'
  s.version     = '0.0.0'
  s.date      = '2020-09-07'
  s.summary     = 'Everything you need to play a game of checkers.'
  s.files     = Dir.glob('lib/**/*')
  s.require_paths = 'lib'

  s.required_ruby_version = '>= 2.4.0'

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'simplecov'
end