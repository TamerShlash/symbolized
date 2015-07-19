# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'symbolized/version'

Gem::Specification.new do |s|
  s.name         = 'symbolized'
  s.version      = Symbolized::VERSION
  s.licenses     = ['MIT']
  s.summary      = "Symbolized HashWithIndifferentAccess"
  s.description  = "Hash with indifferent access, with keys stored internally as symbols."
  s.authors      = ["Tamer Shlash"]
  s.email        = 'mr.tamershlash@gmail.com'
  s.files        = Dir["lib/**/*", "LICENSE", "README.md"]
  s.require_path = 'lib'
  s.homepage     = 'https://github.com/TamerShlash/symbolized'

  s.add_development_dependency 'minitest',   '~> 5.1'
end
