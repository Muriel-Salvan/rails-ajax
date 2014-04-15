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
    json_params = params
    # Use this action to modify the RailsAjax configuration
    RailsAjax.configure do
      main_container "##{json_params['main_container']}" if json_params['main_container']
      ['notice', 'alert', 'error'].each do |flash_type|
        flash_containers(flash_type.to_sym => "##{json_params["flash_container_#{flash_type}"]}") if json_params["flash_container_#{flash_type}"]
      end
    end
    redirect_to root_path
  end

  def json2
    respond_to do |format|
      format.json
    end
  end

  def json5
    render json: {
      'json5.1' => 'ok5.1',
      'json5.2' => 'ok5.2'
    }
  end

  def error404
    render status: :not_found
  end

  def empty_page
    head status: params[:status]
  end

end
