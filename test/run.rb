test_dirs = [
  'dummy_rails4'
]
# If we are not in Travis, add dummy_rails3
# TODO (Travis): Make Rails3 tests pass
test_dirs << 'dummy_rails3' if !ENV.key?('TRAVIS_CONTEXT')

test_root_dir = File.expand_path(File.dirname(__FILE__))
errors = []
test_dirs.each do |test_directory|
	Bundler.with_clean_env do
		puts
		puts
		puts "======= Executing test suite in #{test_directory} ======="
		rails_root_dir = "#{test_root_dir}/#{test_directory}"
		Dir.chdir(rails_root_dir)
		# cucumber/rails uses RAILS_ROOT to know where the Rails application is.
		# Force it as otherwise it looks in features/../..
		ENV['RAILS_ROOT'] = rails_root_dir
		ENV['RAILS_VERSION'] = rails_root_dir[-1]
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
