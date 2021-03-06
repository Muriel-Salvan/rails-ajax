# Main namespace encapsulating all rails-ajax API
module RailsAjax

  # The configuration
  #   <em>RailsAjax::Configuration</em>
  @configuration = RailsAjax::Configuration.new

  # Give access to the configuration
  #
  # Return::
  # * <em>RailsAjax::Configuration</em>: The RailsAjax configuration
  def self.config
    @configuration
  end

  # Configure RailsAjax
  #
  # Parameters::
  # * *config_block* (_CodeBlock_): Block called that will contain all configuration directives
  def self.configure(&config_block)
    @configuration.instance_eval(&config_block)
  end

  # Find if we use rails-ajax for a given set of options applicable to a link
  #
  # Parameters::
  # * *options* (<em>map<Symbol,Object></em>): The options provided to a link (used in link_to or form_tag)
  # Result::
  # * _Boolean_: Would this link be handled by rails-ajax?
  def self.rails_ajaxifiable?(options)
    options[:use_rails_ajax] != false && # User has not removed rails-ajax voluntarily
    options[:target].nil? && # Open in the same window and
    options[:onclick].nil? && # Do not override the onclick event
    !options.key?(:remote) # User has not specified Ajax call itself
  end

end
