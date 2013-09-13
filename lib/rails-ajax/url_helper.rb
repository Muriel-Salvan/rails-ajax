#--
# Copyright (c) 2012 Muriel Salvan (Muriel@X-Aeon.com)
# Licensed under the terms specified in LICENSE file. No warranty is provided.
#++

module RailsAjax

  # Module defining methods to include in ActionView::Helpers::FormHelper
  module UrlHelper

    # Adapt link_to method to handle Ajax queries automatically
    def link_to(*args, &block)
      if (RailsAjax.config.Enabled)
        lName = args.first
        lOptions = args.second || {}
        lHTMLOptions = args.third || {}
        # Decide if we use rails-ajax or not for this link
        if RailsAjax::rails_ajaxifiable?(lHTMLOptions)
          # Adapt the link
          if block_given?
            return super(lName, lOptions, lHTMLOptions.merge({ :remote => true, :'data-rails-ajax-remote' => true })) do
              block.call
            end
          else
            return super(lName, lOptions, lHTMLOptions.merge({ :remote => true, :'data-rails-ajax-remote' => true }))
          end
        elsif block_given?
          # Don't use Rails-Ajax
          return super(*args) do
            block.call
          end
        else
          return super(*args)
        end
      elsif block_given?
        # Don't use Rails-Ajax
        return super(*args) do
          block.call
        end
      else
        return super(*args)
      end
    end

  end

end
