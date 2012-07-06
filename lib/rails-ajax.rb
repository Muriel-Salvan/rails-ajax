#--
# Copyright (c) 2012 Muriel Salvan (Muriel@X-Aeon.com)
# Licensed under the terms specified in LICENSE file. No warranty is provided.
#++

module RailsAjax

  # Give the root directory of the RailsAjax installation
  #
  # Return::
  # * _String_: RailsAjax root directory
  def self.root
    return File.expand_path("#{File.dirname(__FILE__)}/..")
  end

end

require 'rails-ajax/railtie'
