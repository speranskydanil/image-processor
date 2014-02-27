class RegistrationsController < Devise::RegistrationsController
  def create
    if verify_recaptcha
      super
    else
      build_resource

      flash[:alert] = I18n.t('auth.recaptcha_error')
      redirect_to new_user_registration_path
    end
  end
end
