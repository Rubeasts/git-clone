# frozen_string_literal: true
require 'rake/testtask'

require_relative 'lib/getclonedata'

task default: :spec

Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/*_spec.rb'
  t.warning = false
end

desc 'delete clone repository'
task :wipe do
  GetCloneData::ClonedRepo.wipe
end

namespace :quality do
  desc 'run all quality checks'
  task all: [:rubocop, :flog, :flay]

  task :flog do
    sh 'flog lib/'
  end

  task :flay do
    sh 'flay lib/'
  end

  task :rubocop do
    sh 'rubocop'
  end
end
