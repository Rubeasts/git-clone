# frozen_string_literal: true

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'

require_relative '../lib/getclonedata'

HAPPY_GIT_URL = 'git://github.com/rjollet/DeepViz.git'
SAD_GIT_URL = 'git://github.com/notexistowner/notexistrepo.git'
