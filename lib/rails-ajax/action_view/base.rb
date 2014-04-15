module ActionView

  # Base class having view methods.
  # Overload some methods to get rails-ajax functionality.
  class Base

    include RailsAjax::UrlHelper
    include RailsAjax::FormTagHelper

  end

end
