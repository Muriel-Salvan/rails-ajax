#--
# Copyright (c) 2012 Muriel Salvan (Muriel@X-Aeon.com)
# Licensed under the terms specified in LICENSE file. No warranty is provided.
#++

# Alias standard methods, and add new ones to adapt them to AJAX calls
module ActionController

  class Base

    include RailsAjax::Controller

  end

end
