module RailsAjax

  # Module defining new methods that will be part of every controller
  module Controller

    # Render
    # Adapt to AJAX calls, by returning the following JSON object that will be interpreted by client side JavaScript.
    def render(*options, &block)
      if (RailsAjax.config.enabled?)
        args = _normalize_args(*options, &block)
        if ((request.xhr?) and
            (!args.has_key?(:partial)) and
            (!args.has_key?(:layout)) and
            (!args.has_key?(:json)) and
            (params['format'] != 'json') and
            (self.content_type != 'application/json'))
          logger.debug "[RailsAjax] render: options=#{options.inspect} block?#{block != nil} flash=#{flash.inspect} | Normalized arguments: #{args.inspect}"

          # If we have a redirection, use redirect_to
          if (args[:location] == nil)
            # Complete arguments if needed
            # We don't want a special layout for Ajax requests: this was asked using AJAX for a page to be displayed in the main content
            args[:layout] = false
            # Render
            main_content = render_to_string(args, &block)

            # Send JSON result
            # Use 'application/json'
            self.content_type = 'application/json'
            self.response_body = get_json_response(
              :elements_to_refresh => {
                RailsAjax.config.main_container => main_content
              }
            ).to_json
          elsif (args[:status] == nil)
            redirect_to args[:location]
          else
            redirect_to args[:location], args[:status]
          end

        else
          super(*options, &block)
        end
      else
        super(*options, &block)
      end

    end

    # Render a redirection
    # Adapt to AJAX calls
    def redirect_to(options = {}, response_status = {})
      if (RailsAjax.config.enabled? and request.xhr?)
        logger.debug "[RailsAjax] redirect_to: options=#{options.inspect} response_status=#{response_status.inspect}"
        # Use 'application/json'
        self.content_type = 'application/json'
        self.response_body = get_json_response(
          :redirect_to => url_for(options)
        ).to_json
      else
        super(options, response_status)
      end
    end

    protected

    # Mark given DOM elements (selected using a CSS selector) to be refreshed with a partial's content
    #
    # Parameters::
    # * *css_selector* (_String_): The CSS selector to be used to refresh elements
    # * *partial_name* (_String_): Name of the partial to be used to refresh these elements
    def refresh_dom_with_partial(css_selector, partial_name)
      if RailsAjax.config.enabled?
        logger.debug "[RailsAjax] Mark partial #{partial_name} to be refreshed in #{css_selector}"
        @partials_to_refresh = {} if (defined?(@partials_to_refresh) == nil)
        @partials_to_refresh[css_selector] = partial_name
      end
    end

    # Add a Javascript to be executed just after the Ajax call
    # This is used to execute special Ajax handling that is not needed in case the same request is made without Ajax
    #
    # Parameters::
    # * *js_code* (_String_): Javascript to be executed
    def execute_javascript(js_code)
      if RailsAjax.config.enabled?
        logger.debug "[RailsAjax] Add javascript to be executed: #{js_code[0..255]}"
        @js_to_execute = [] if (defined?(@js_to_execute) == nil)
        @js_to_execute << js_code
      end
    end

    private

    # Get the JSON object that will be sent to an Ajax request.
    # Include the partials marked to be refreshed.
    # Include Javascripts to be executed.
    # Include Flash messages.
    # Structure of the JSON object:
    # * *:div_contents* (<em>map<String,String></em>): The content of DOM elements to be replaced, indexed by CSS selector.
    # * *:page_title* (_String_): The new page title
    # * *:redirect_to* (_String_): Page to be redirected to
    # * *:js_to_execute* (<em>list<String></em>): Javascripts to be executed
    #
    # Parameters::
    # * *options* (<em>map<Symbol,Object></em>): Options [optional = {}]
    #   * *:elements_to_refresh* (<em>map<String,String></em>): List of elements to be refreshed (HTML code), indexed by their CSS selector [optional = {}]
    #   * *:redirect_to* (_String_): URL to redirect to [optional = nil]
    # Return::
    # * <em>map<Object,Object></em>: The corresponding JSON data
    def get_json_response(options = {})
      json_result = {}

      elements_contents = options[:elements_to_refresh] || {}
      if (defined?(@partials_to_refresh) != nil)
        @partials_to_refresh.each do |css_selector, partial_name|
          elements_contents[css_selector] = render_to_string(:partial => partial_name)
        end
      end
      RailsAjax.config.flash_containers.each do |flash_type, css_selector|
        elements_contents[css_selector] = flash[flash_type]
      end
      json_result[:js_to_execute] = @js_to_execute if (defined?(@js_to_execute) != nil)
      json_result[:div_contents] = elements_contents
      json_result[:redirect_to] = options[:redirect_to] if (options[:redirect_to] != nil)

      return json_result
    end

  end

end
