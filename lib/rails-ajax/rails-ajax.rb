#--
# Copyright (c) 2012 Muriel Salvan (Muriel@X-Aeon.com)
# Licensed under the terms specified in LICENSE file. No warranty is provided.
#++

module RailsAjax

  # The configuration
  #   <em>RailsAjax::Configuration</em>
  @@Configuration = RailsAjax::Configuration.new

  # Give access to the configuration
  #
  # Return::
  # * <em>RailsAjax::Configuration</em>: The RailsAjax configuration
  def self.config
    return @@Configuration
  end

  # Configure RailsAjax
  #
  # Parameters::
  # * *iProcConfig* (_CodeBlock_): Block called that will contain all configuration directives
  def self.configure(&iProcConfig)
    @@Configuration.instance_eval(&iProcConfig)
  end

end
