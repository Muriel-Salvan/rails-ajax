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
        if (lHTMLOptions[:target] == nil)
          if block_given?
            return super(lName, lOptions, lHTMLOptions.merge({:remote => true})) do
              block.call
            end
          else
            return super(lName, lOptions, lHTMLOptions.merge({:remote => true}))
          end
        elsif block_given?
          # It is specified to open the link in another frame. Don't use AJAX.
          return super(*args) do
            block.call
          end
        else
          return super(*args)
        end
      elsif block_given?
        return super(*args) do
          block.call
        end
      else
        return super(*args)
      end
    end

  end

end
