Gem::Specification.new do |s|
  s.name        = 'libcruisecontrol'
  s.version     = '0.1.3'
  s.summary     = 'Interact with Cruise Control'
  s.description = 'libcruisecontrol is a library to interact with Cruise Control continuous integration tool'
  s.files	    = Dir['lib/**/*'] + Dir['test/**/*']

  s.author      = 'Jonas Alves'
  s.email       = 'jonasfa@gmail.com'
  s.homepage    = 'http://github.com/jonasfa/libcruisecontrol'

  s.add_dependency('activesupport', '>= 2.3.0')
end
