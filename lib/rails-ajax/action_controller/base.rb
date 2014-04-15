module ActionController

  # Base class having controller methods.
  # Overload some methods to get rails-ajax functionality.
  class Base

    include RailsAjax::Controller

  end

end
