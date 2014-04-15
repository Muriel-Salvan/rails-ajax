class HomeController < ApplicationController

  # Page2 contains extra functionnalities if activated using params
  def page2

    # Refresh the other div from the layout
    refresh_dom_with_partial('div#layout_other_div', '/home/other_div') if params['refresh'] == '1'

    # Execute an additional script when rails-ajax is used (scripts from the page itself are already executed automatically)
    execute_javascript('alert(\'Javascript executed from Page 2 using rails-ajax. If rails-ajax is disabled, this Javascript alert should not appear.\');') if params['script'] == '1'

    # Update flash messages
    if params['flash'] == '1'
      flash.now[:notice] = 'Notice flash message'
      flash.now[:alert] = 'Alert flash message'
      flash.now[:error] = 'Error flash message'
    end

    # Redirect if needed
    redirect_to 'page1' if params['redirect'] == '1'

    # Still renders page2 by default in the layout content.
    # Redirects are also rendered automatically. No need for extra code.

  end

end
