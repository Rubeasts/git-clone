# frozen_string_literal: true
$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'getclonedata/version'

Gem::Specification.new do |s|
  s.name        =  'getclonedata'
  s.version     =  GetCloneData::VERSION

  s.summary     =  'Clone git repo and check the code quality using objective measure (flog, flay, rubocop)'
  s.description =  'Extracts repository code quality'
  s.authors     =  ['Renaud Jollet',
                    'Nicholas Danks',
                    'Sami Larrousi Tribek']
  s.email       =  ['renaudjollet@neurow.org',
                    'nicholasdanks@hotmail.com',
                    'sami@slt.fr']

  s.files       =  `git ls-files`.split("\n")
  s.test_files  =  `git ls-files -- spec/*`.split("\n")
  s.executables << 'getclonedata'

  s.add_runtime_dependency 'http', '~> 2.1'
  s.add_runtime_dependency 'json', '~> 2.0'
  s.add_runtime_dependency 'json', '~> 2.0'
  s.add_runtime_dependency 'flog', '~> 4.4'
  s.add_runtime_dependency 'flay', '~> 2.8'
  s.add_runtime_dependency 'rubocop', '~> 0.42'

  s.add_development_dependency 'minitest', '~> 5.9'
  s.add_development_dependency 'minitest-rg', '~> 5.2'
  s.add_development_dependency 'rake', '~> 11.3'
  s.add_development_dependency 'vcr', '~> 3.0'
  s.add_development_dependency 'webmock', '~> 2.1'
  s.add_development_dependency 'simplecov', '~> 0.12'

  s.homepage    =  'https://github.com/Rubeasts/gitget'
  s.license     =  'MIT'
end
