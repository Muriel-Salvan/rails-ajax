#--
# Copyright (c) 2012 Muriel Salvan (Muriel@X-Aeon.com)
# Licensed under the terms specified in LICENSE file. No warranty is provided.
#++

module RailsAjax

  # Class used to configure and store the configuration of RailsAjax
  class Configuration

    # Indicate if RailsAjax is enabled
    #
    # _Boolean_
    attr_reader :Enabled

    # The main container
    #
    # _String_
    attr_reader :MainContainer

    # The flash containers
    #
    # <em>map< Symbol, String ></em>
    attr_reader :FlashContainers

    # Debug alerts ?
    #
    # _Boolean_
    attr_reader :DebugAlerts

    # Constructor
    def initialize
      # Set default values here
      @Enabled = true
      @MainContainer = 'body'
      @FlashContainers = {}
      @DebugAlerts = false
    end

    # Do we activate RailsAjax ?
    #
    # Parameters::
    # * *iSwitch* (_Boolean_): Do we activate RailsAjax ?
    def enable(iSwitch)
      @Enabled = iSwitch
    end

    # Define the main container
    #
    # Parameters::
    # * *iSelector* (_String_): Selector used to identify the container
    def main_container(iSelector)
      @MainContainer = iSelector
    end

    # Define the flash containers
    #
    # Parameters::
    # * *iMapSelectors* (<em>map<Symbol,String></em>): The map of selectors, per flash message type (:alert, :notice...)
    def flash_containers(iMapSelectors)
      @FlashContainers.merge!(iMapSelectors)
    end

    # Do we activate debugging alerts ?
    #
    # Parameters::
    # * *iSwitch* (_Boolean_): Do we activate debugging alerts ?
    def debug_alerts(iSwitch)
      @DebugAlerts = iSwitch
    end

  end

end
