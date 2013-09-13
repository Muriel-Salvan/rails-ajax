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

  # Find if we use rails-ajax for a given set of options applicable to a link
  #
  # Parameters::
  # * *iOptions* (<em>map<Symbol,Object></em>): The options provided to a link (used in link_to or form_tag)
  # Result::
  # * _Boolean_: Would this link be handled by rails-ajax?
  def self.rails_ajaxifiable?(iOptions)
    return ((iOptions[:use_rails_ajax] != false) and # User has not removed rails-ajax voluntarily
            (iOptions[:target] == nil) and # Open in the same window and
            (!iOptions.has_key?(:remote))) # User has not specified Ajax call itself
  end

end
