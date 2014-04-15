class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :init_session_if_new

  private

  # Initialize the session if it is a new one
  def init_session_if_new
    if session[:counters].nil?
      session[:counters] = {
        layout: 0,
        index: 0,
        page1: 0,
        page2: 0,
        page_with_anchor: 0,
        page_with_refresh_layoutdiv: 0,
        page_with_railsajax_javascript: 0,
        page_with_javascript: 0,
        page_with_jquery_ready: 0,
        page_with_flash: 0,
        layout_div1: 0,
        layout_div2: 0,
        sign_up: 0,
        sign_in: 0,
        error_404: 0
      }
    end
  end

end
