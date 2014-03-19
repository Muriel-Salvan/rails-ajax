module RailsAjax

  # Module defining methods to include in ActionView::Helpers::FormHelper
  module UrlHelper

    # Adapt link_to method to handle Ajax queries automatically
    def link_to(name = nil, options = nil, html_options = nil, &block)
      options, html_options = name, options if block_given?
      html_options ||= {}
      html_options.merge!({ :remote => true, :'data-rails-ajax-remote' => true }) if (RailsAjax.config.enabled? and RailsAjax.rails_ajaxifiable?(html_options))
      if block_given?
        return super(options, html_options, &block)
      else
        return super(name, options, html_options)
      end
    end

    # Adapt button_to method to handle Ajax queries automatically
    def button_to(name = nil, options = nil, html_options = nil, &block)
      html_options, options = options, name if block_given?
      html_options ||= {}
      html_options.merge!({ :remote => true, :form => {:'data-rails-ajax-remote' => true} }) if (RailsAjax.config.enabled? and RailsAjax.rails_ajaxifiable?(html_options))
      if block_given?
        return super(options, html_options, &block)
      else
        return super(name, options, html_options)
      end
    end


  end

end
