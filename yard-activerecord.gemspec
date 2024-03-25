require_relative "lib/yard-activerecord/version"

Gem::Specification.new do |s|
  s.name        = "yard-activerecord"
  s.version     = YARD::ActiveRecord::VERSION
  s.authors     = ["Theodor Tonum"]
  s.email       = ["theodor@tonum.no"]
  s.homepage    = "https://github.com/theodorton/yard-activerecord"
  s.summary     = %q{ActiveRecord Handlers for YARD}
  s.description = %q{
    YARD-Activerecord is a YARD extension that handles and interprets methods
    used when developing applications with ActiveRecord. The extension handles
    attributes, associations, delegates and scopes. A must for any Rails app
    using YARD as documentation plugin. }
  s.license     = "MIT"

  s.files       = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{lib,templates}/**/*", "LICENSE", "README.md"]
  end

  s.add_dependency 'yard', '>= 0.8.3'
  s.add_dependency 'activesupport'

  s.add_development_dependency 'rspec'
end
