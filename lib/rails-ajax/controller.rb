#--
# Copyright (c) 2012 Muriel Salvan (Muriel@X-Aeon.com)
# Licensed under the terms specified in LICENSE file. No warranty is provided.
#++

module RailsAjax

  # Module defining new methods that will be part of every controller
  module Controller

    protected

    # Render
    # Adapt to AJAX calls, by returning the following JSON object that will be interpreted by client side JavaScript.
    def render(*iArgs, &iBlock)
      if (RailsAjax.config.Enabled)
        lArgs = _normalize_args(*iArgs, &iBlock)
        if ((request.xhr?) and
            (!lArgs.has_key?(:partial)) and
            (!lArgs.has_key?(:layout)) and
            (!lArgs.has_key?(:json)))
          logger.debug "[RailsAjax] render: iArgs=#{iArgs.inspect} iBlock?#{iBlock != nil} flash=#{flash.inspect} | Normalized arguments: #{lArgs.inspect}"

          # If we have a redirection, use redirect_to
          if (lArgs[:location] == nil)
            # Complete arguments if needed
            # We don't want a special layout for Ajax requests: this was asked using AJAX for a page to be displayed in the main content
            lArgs[:layout] = false

            # Render
            lMainPage = nil
            if (iBlock == nil)
              lMainPage = render_to_string(lArgs)
            else
              lMainPage = render_to_string(lArgs) do
                iBlock.call
              end
            end

            # Send JSON result
            # Use 'application/json'
            self.content_type = 'application/json'
            self.response_body = get_json_response(
              :css_to_refresh => {
                RailsAjax::config.MainContainer => lMainPage
              }
            ).to_json
          elsif (lArgs[:status] == nil)
            redirect_to lArgs[:location]
          else
            redirect_to lArgs[:location], lArgs[:status]
          end

        elsif (iBlock == nil)
          super(*iArgs)
        else
          super(*iArgs) do
            iBlock.call
          end
        end
      elsif (iBlock == nil)
        super(*iArgs)
      else
        super(*iArgs) do
          iBlock.call
        end
      end

    end

    # Render a redirection
    # Adapt to AJAX calls
    def redirect_to(iOptions = {}, iResponseStatus = {})
      if (RailsAjax.config.Enabled and request.xhr?)
        logger.debug "[RailsAjax] redirect_to: iOptions=#{iOptions.inspect} iResponseStatus=#{iResponseStatus.inspect}"
        # Use 'application/json'
        self.content_type = 'application/json'
        self.response_body = get_json_response(
          :redirect_to => url_for(iOptions)
        ).to_json
      else
        super(iOptions, iResponseStatus)
      end
    end

    protected

    # Mark given DOM elements (selected using a CSS selector) to be refreshed with a partial's content
    #
    # Parameters::
    # * *iCSSSelector* (_String_): The CSS selector to be used to refresh elements
    # * *iPartialName* (_String_): Name of the partial to be used to refresh these elements
    def refresh_dom_with_partial(iCSSSelector, iPartialName)
      if RailsAjax.config.Enabled
        logger.debug "[RailsAjax] Mark partial #{iPartialName} to be refreshed in #{iCSSSelector}"
        if (defined?(@PartialsToRefresh) == nil)
          @PartialsToRefresh = {}
        end
        @PartialsToRefresh[iCSSSelector] = iPartialName
      end
    end

    # Add a Javascript to be executed just after the Ajax call
    # This is used to execute special Ajax handling that is not needed in case the same request is made without Ajax
    #
    # Parameters::
    # * *iJS* (_String_): Javascript to be executed
    def execute_javascript(iJS)
      if RailsAjax.config.Enabled
        logger.debug "[RailsAjax] Add javascript to be executed: #{iJS[0..255]}"
        if (defined?(@JSToExecute) == nil)
          @JSToExecute = []
        end
        @JSToExecute << iJS
      end
    end

    private

    # Get the JSON object that will be sent to an Ajax request.
    # Include the partials marked to be refreshed.
    # Include Javascripts to be executed
    # Structure of the JSON object:
    # * *:div_contents* (<em>map<String,String></em>): The content of DOM elements to be replaced, indexed by CSS selector.
    # * *:page_title* (_String_): The new page title
    # * *:redirect_to* (_String_): Page to be redirected to
    # * *:js_to_execute* (<em>list<String></em>): Javascripts to be executed
    #
    # Parameters::
    # * *iOptions* (<em>map<Symbol,Object></em>): Options [optional = {}]
    #   * *:css_to_refresh* (<em>map<String,String></em>): List of CSS to be refreshed, along with their HTML code [optional = {}]
    #   * *:redirect_to* (_String_): URL to redirect to [optional = nil]
    # Return::
    # * <em>map<Object,Object></em>: The corresponding JSON data
    def get_json_response(iOptions = {})
      rJSON = {}

      lDivContents = iOptions[:css_to_refresh] || {}
      if (defined?(@PartialsToRefresh) != nil)
        @PartialsToRefresh.each do |iCSSSelector, iPartialName|
          lDivContents[iCSSSelector] = render_to_string(:partial => iPartialName)
        end
      end
      RailsAjax::config.FlashContainers.each do |iSymFlashType, iSelector|
        lDivContents[iSelector] = flash[iSymFlashType]
      end
      rJSON[:js_to_execute] = @JSToExecute if (defined?(@JSToExecute) != nil)
      rJSON[:div_contents] = lDivContents
      rJSON[:redirect_to] = iOptions[:redirect_to] if (iOptions[:redirect_to] != nil)

      return rJSON
    end

  end

end
