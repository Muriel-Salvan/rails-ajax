#--
# Copyright (c) 2012 Muriel Salvan (Muriel@X-Aeon.com)
# Licensed under the terms specified in LICENSE file. No warranty is provided.
#++

test_root_dir = File.expand_path(File.dirname(__FILE__))
errors = []
[
  'dummy_rails3',
  'dummy_rails4'
].each do |test_directory|
	Bundler.with_clean_env do
		puts
		puts
		puts "======= Executing test suite in #{test_directory} ======="
		rails_root_dir = "#{test_root_dir}/#{test_directory}"
		Dir.chdir(rails_root_dir)
		# cucumber/rails uses RAILS_ROOT to know where the Rails application is.
		# Force it as otherwise it looks in features/../..
		ENV['RAILS_ROOT'] = rails_root_dir
		# Make sure we have correct Gem versions
		system('bundle install')
		system('bundle exec cucumber ../features')
		exit_status = $?.exitstatus
		errors << "[#{test_directory}] - cucumber failed with exit status #{exit_status}" if (exit_status != 0)
		puts
		puts
	end
end

raise "#{errors.size} failed cucumber test suites:\n#{errors.join("\n")}" if (!errors.empty?)
