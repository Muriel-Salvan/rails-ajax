#--
# Copyright (c) 2012 Muriel Salvan (Muriel@X-Aeon.com)
# Licensed under the terms specified in LICENSE file. No warranty is provided.
#++

module RailsAjax

  # Module defining methods to include in ActionView::Helpers::FormHelper
  module UrlHelper

    # Adapt link_to method to handle Ajax queries automatically
    def link_to(name = nil, options = nil, html_options = nil, &block)
      options, html_options = name, options if block_given?
      html_options ||= {}
      if (RailsAjax.config.Enabled and
          RailsAjax::rails_ajaxifiable?(html_options))
        html_options.merge!({ :remote => true, :'data-rails-ajax-remote' => true })
      end
      if block_given?
        return super(options, html_options) do
          block.call
        end
      else
        return super(name, options, html_options)
      end
    end

  end

end
