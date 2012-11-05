#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Ocelots::Application.load_tasks

Rake::Task[:default].prerequisites.clear
# task :default => %w(db:drop db:migrate analyzer:flay analyzer:rails_best_practices spec stats)
task :default => %w(db:drop db:migrate db:test:prepare analyzer:flay spec stats)