# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'whitehouse_speech/version'

Gem::Specification.new do |s|
  s.name = 'Whitehouse Speech Parser'
  s.version = WhitehouseSpeech::VERSION
  s.platform = Gem::Platform::Ruby
  s.authors = ['Sherman Mui']
  s.email = ['sherman@meatchunks.com']
  s.homepage = ''
  s.summary = %q{Parses White House press HTML pages for WordSeer.}
  s.description = %q{Parses White House press HTML pages into XML documents for WordSeer to perform textual analaysis.}

  s.files = `git ls-files`.split('\n')
  s.test_files = `git ls-files -- {test,spec,features}/*`.split('\n')
  s.executables = `git ls-files -- bin/*`.split('\n').map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
