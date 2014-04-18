# Always put it first
require 'English'

test_root_dir = File.expand_path(File.dirname(__FILE__))
errors = []
%w(dummy_rails3 dummy_rails4).each do |test_directory|
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
    # Create and prepare database
    system('bundle exec rake db:migrate --trace')
    # Prepare test db for Rails 3 only. This is deprecated for Rails 4.
    system('bundle exec rake db:test:prepare --trace') if ENV['RAILS_VERSION'] == '3'
    # Execute tests suite
    system({ 'CODECLIMATE_REPO_TOKEN' => ENV['CODECLIMATE_REPO_TOKEN'] }, "#{ENV['TRAVIS_CONTEXT'] == '1' ? 'xvfb-run ' : ''}bundle exec cucumber ../features")
    exit_status = $CHILD_STATUS.exitstatus
    errors << "[#{test_directory}] - cucumber failed with exit status #{exit_status}" if exit_status != 0
    puts
    puts
  end
end

raise "#{errors.size} failed cucumber test suites:\n#{errors.join("\n")}" unless errors.empty?
