#!/usr/bin/env ruby

require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean
