#--
# Copyright (c) 2012 Muriel Salvan (Muriel@X-Aeon.com)
# Licensed under the terms specified in LICENSE file. No warranty is provided.
#++

class HomeController < ApplicationController

  def page_with_refresh_layoutdiv
    refresh_dom_with_partial('div#LayoutDiv2', 'layout_div2')
  end

  def page_with_railsajax_javascript
    execute_javascript('alert(\'Javascript executed from page_with_railsajax_javascript\');')
  end

  def redirect
    redirect_to page1_path
  end

  def redirect_with_flash
    flash[:notice] = 'Flash notice'
    flash[:alert] = 'Flash alert'
    flash[:error] = 'Flash error'
    redirect_to page1_path
  end

  def page_with_flash
    flash[:notice] = 'Flash notice'
    flash[:alert] = 'Flash alert'
    flash[:error] = 'Flash error'
  end

  def configure
    lParams = params
    # Use this action to modify the RailsAjax configuration
    RailsAjax::configure do
      main_container "##{lParams['main_container']}" if (lParams['main_container'] != nil)
      [ 'notice', 'alert', 'error' ].each do |iFlashType|
        flash_containers(iFlashType.to_sym => "##{lParams["flash_container_#{iFlashType}"]}") if (lParams["flash_container_#{iFlashType}"] != nil)
      end
    end
    redirect_to root_path
  end

  def json3
    respond_to do |format|
      format.json
    end
  end

end
