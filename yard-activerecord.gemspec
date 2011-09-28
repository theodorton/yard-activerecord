# -*- encoding: utf-8 -*-
require 'YARD'
require File.dirname(__FILE__) + '/lib/yard-activerecord'
require File.dirname(__FILE__) + '/lib/yard-activerecord/version'

Gem::Specification.new do |s|
  s.name        = "yard-activerecord"
  s.version     = YARD::ActiveRecord::VERSION
  s.authors     = ["Theodor Tonum"]
  s.email       = ["theodor@tonum.no"]
  s.homepage    = ""
  s.summary     = %q{ActiveRecord Handlers for YARD}
  s.description = %q{
    YARD-Activerecord is a YARD extension that handles and interprets methods
    used when developing applications with ActiveRecord. The extension handles
    attributes, associations, delegates and scopes. A must for any Rails app
    using YARD as documentation plugin. }

  s.add_development_dependency 'yard', '>= 0.7.0'

  s.files         = `git ls-files`.split("\n")
  s.require_path  = "lib"
end
