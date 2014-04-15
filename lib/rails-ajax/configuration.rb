module RailsAjax

  # Class used to configure and store the configuration of RailsAjax
  class Configuration

    # Indicate if RailsAjax is enabled
    #
    # Return::
    # * _Boolean_: Is rails-ajax enabled?
    def enabled?
      @enabled
    end

    # Debug alerts ?
    #
    # Return::
    # * _Boolean_: Do we switch on debug alerts?
    def debug_alerts?
      @debug_alerts
    end

    # Constructor
    def initialize
      # Set default values here
      @enabled = true
      @main_container = 'body'
      @flash_containers = {}
      @debug_alerts = false
    end

    # Do we activate RailsAjax ?
    #
    # Parameters::
    # * *switch* (_Boolean_): Do we activate RailsAjax ?
    def enable(switch)
      @enabled = switch
    end

    # Define the main container if provided, and return it
    #
    # Parameters::
    # * *selector* (_String_): Selector used to identify the container [optional = nil]
    # Return::
    # * _String_: The CSS selector of the main container
    def main_container(selector = nil)
      @main_container = selector if selector
      @main_container
    end

    # Define the flash containers (add them to already present ones) if provided, and return them
    #
    # Parameters::
    # * *selectors_map* (<em>map<Symbol,String></em>): The map of selectors, per flash message type (:alert, :notice...)
    # Return::
    # * <em>map<Symbol,String></em>: The map of selectors [optional = nil]
    def flash_containers(selectors_map = nil)
      @flash_containers.merge!(selectors_map) if selectors_map
      @flash_containers
    end

    # Do we activate debugging alerts ?
    #
    # Parameters::
    # * *switch* (_Boolean_): Do we activate debugging alerts ?
    def debug_alerts(switch)
      @debug_alerts = switch
    end

  end

end
