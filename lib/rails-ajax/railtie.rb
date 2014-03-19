module RailsAjax

  # Class defining how Rails-Ajax is plugged into Rails
  class Railtie < Rails::Railtie

    # Define Rake tasks
    rake_tasks do
      load "#{RailsAjax.root}/tasks/rails-ajax_tasks.rake"
    end

    initializer :'rails-ajax.initialize' do |app|
      # Require all files
      require 'rails-ajax/configuration'
      require 'rails-ajax/rails-ajax'
      require 'rails-ajax/controller'
      require 'rails-ajax/form_tag_helper'
      require 'rails-ajax/url_helper'
      require 'rails-ajax/action_controller/base'
      require 'rails-ajax/action_view/base'
      # Add a new assets path for javascript
      app.config.assets.paths << "#{RailsAjax.root}/assets/javascripts"
    end

  end

end
