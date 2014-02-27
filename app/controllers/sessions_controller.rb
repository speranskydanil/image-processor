class SessionsController < Devise::SessionsController
  def create
    if verify_recaptcha
      super
    else
      return_to = session[:return_to]
      sign_out
      session[:return_to] = return_to

      flash[:alert] = I18n.t('auth.recaptcha_error')
      redirect_to new_user_session_path
    end
  end
end
