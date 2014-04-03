puts "FROM CUCUMBER: CODECLIMATE_REPO_TOKEN=#{ENV['CODECLIMATE_REPO_TOKEN']}"
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start
