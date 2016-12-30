# frozen_string_literal: true

require 'json'
require 'flog'
require 'flay'
require 'path_expander'

files = Dir.glob(File.join(File.dirname(__FILE__), 'getclonedata/*.rb'))
files.each { |lib| require_relative lib }
