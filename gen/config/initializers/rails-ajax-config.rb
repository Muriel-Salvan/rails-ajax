# RailsAjax configuration
RailsAjax.configure do

  # Enable or disable RailsAjax.
  # If disabled, RailsAjax methods will be useless, and corresponding JavaScript will be removed.
  # When changing this switch, you have to:
  # * Remove the tmp/cache directory
  # * Precompile your assets in production mode
  # * Restart your server
  enable true

  # Set the default main container that will receive the result of Ajax requests.
  # This container will get what is rendered by default when render is called.
  main_container 'body'

  # Set the containers that will receive Rails' flash messages.
  # Use these if those containers are part of your layout and will not be refreshed by each Ajax call. In this case RailsAjax will still refresh them.
  # If not set for a given flash message type, you have to return the corresponding flash yourself in each Ajax's response.
  flash_containers(
    :notice => '#FlashNotice',
    :error => '#FlashError',
    :alert => '#FlashAlert'
  )

  # Activate debugging alerts in the JS code.
  # This will pop plenty of JS dialogs at each stage of RailsAjax calls, useful to better debug what is going wrong.
  # When changing this switch, you have to:
  # * Precompile your assets in production mode
  # * Restart your server
  debug_alerts false

end
