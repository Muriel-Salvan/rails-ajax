module RailsAjax

  # Module defining methods to include in ActionView::Helpers::FormTagHelper
  module FormTagHelper

    # Replaces form_tag with an Ajax updated version
    def form_tag(url_for_options = {}, options = {}, &block)
      options.merge!({ :remote => true, :'data-rails-ajax-remote' => true }) if (RailsAjax.config.enabled? and RailsAjax.rails_ajaxifiable?(options))
      return super(url_for_options, options, &block)
    end

  end

end
