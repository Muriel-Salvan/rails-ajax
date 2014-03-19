# Alias standard methods, and add new ones to adapt them to AJAX calls
module ActionController

  class Base

    include RailsAjax::Controller

  end

end
