#--
# Copyright (c) 2012 Muriel Salvan (Muriel@X-Aeon.com)
# Licensed under the terms specified in LICENSE file. No warranty is provided.
#++

module RailsAjax

  # Module defining methods to include in ActionView::Helpers::FormTagHelper
  module FormTagHelper

    # Replaces form_tag with an Ajax updated version
    def form_tag(url_for_options = {}, options = {}, &block)
      if (RailsAjax.config.Enabled and
          RailsAjax::rails_ajaxifiable?(options))
        if block_given?
          return super(url_for_options, options.merge({ :remote => true, :'data-rails-ajax-remote' => true })) do
            block.call
          end
        else
          return super(url_for_options, options.merge({ :remote => true, :'data-rails-ajax-remote' => true }))
        end
      elsif block_given?
        return super(url_for_options, options) do
          block.call
        end
      else
        return super(url_for_options, options)
      end
    end

  end

end
