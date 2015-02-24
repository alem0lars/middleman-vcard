# encoding: utf-8

# Prepare environment for requiring gems.
require "rubygems"
require "bundler/setup"

# Require third-party tasks.
require "bundler/gem_tasks"
require "rake"
require "rake/clean"
require "rspec/core/rake_task"
require "yard"

# Require the project main module.
require "middleman-vcard"


RSpec::Core::RakeTask.new

YARD::Rake::YardocTask.new

desc "open a console preloaded with middleman-vcard"
task :console do
  sh "pry --gem", verbose: false
end

task default: [:spec]
