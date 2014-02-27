class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_project

  def set_project
    project = Struct.new('Project', :per_page, :default_per_page)
    @project = project.new('25;50;100;200;400', 100)
  end

  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  before_filter :store_redirect_to_path

  def store_redirect_to_path
    special_actions = %w(sessions#new sessions#create sessions#destroy)

    current_action = "#{params[:controller]}##{params[:action]}"

    unless special_actions.include? current_action
      session[:return_to] = request.fullpath
    end
  end

  before_filter :check_for_anonymous_access

  def check_for_anonymous_access
    unless %w(sessions devise/passwords).include? params[:controller]
      unless current_user
        flash[:error] = I18n.t('auth.access_denied')
        redirect_to new_user_session_path
      end
    end
  end

  def after_sign_in_path_for(resource)
    session[:return_to] || root_url
  end

  def after_sign_out_path_for(resource)
    session[:return_to] || root_url
  end

  def root
    flash.each { |k, v| flash[k] = v }

    if Node.root
      redirect_to Node.root
    else
      render 'nodes/index'
    end
  end
end
