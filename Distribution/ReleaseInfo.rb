RubyPackager::ReleaseInfo.new.
  author(
    :name => 'Muriel Salvan',
    :email => 'muriel@x-aeon.com',
    :web_page_url => 'http://murielsalvan.users.sourceforge.net'
  ).
  project(
    :name => 'Rails-Ajax',
    :web_page_url => 'http://rails-ajax.sourceforge.net',
    :summary => 'Add Ajax capabilities to Rails websites with history, bookmarking, partial refreshes, Rails flashes, user callbacks, scripts execution, redirections.',
    :description => 'Add Ajax capabilities to Rails websites, with minimal code changes. Supports history, bookmarking, partial refreshes, Rails flashes, user callbacks, scripts execution, redirections. Built upon Rails-UJS and jQuery.',
    :image_url => 'http://rails-ajax.sourceforge.net/wiki/images/c/c9/Logo.png',
    :favicon_url => 'http://rails-ajax.sourceforge.net/wiki/images/2/26/Favicon.png',
    :browse_source_url => 'http://github.com/Muriel-Salvan/rails-ajax',
    :dev_status => 'Beta'
  ).
  add_core_files([
    'assets/**/*',
    'gen/**/*',
    'lib/**/*',
    'tasks/**/*'
  ]).
  add_test_files(
    ['rails-ajax.gemspec'] +
    Dir.glob('test/**/*') -
    Dir.glob('test/dummy/log/*.log') -
    Dir.glob('test/dummy/tmp/**/*') -
    Dir.glob('test/dummy/.sass-cache/**/*')
  ).
  add_additional_files([
    'README.rdoc',
    'LICENSE',
    'AUTHORS.rdoc',
    'Credits',
    'ChangeLog',
    'Gemfile',
    'Gemfile.lock',
    'Rakefile'
  ]).
  gem(
    :gem_name => 'rails-ajax',
    :gem_platform_class_name => 'Gem::Platform::RUBY',
    :require_path => 'lib',
    :has_rdoc => true,
    :test_file => 'test/run.rb',
    :gem_dependencies => [
      ['rails', '>= 3.2.1']
    ]
  ).
  source_forge(
    :login => 'murielsalvan',
    :project_unix_name => 'rails-ajax',
    :ask_for_key_passphrase => true
  ).
  ruby_forge(
    :project_unix_name => 'rails-ajax'
  )
