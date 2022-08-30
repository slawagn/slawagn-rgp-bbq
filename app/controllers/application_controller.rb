class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user_can_edit?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [:name]
    )

    devise_parameter_sanitizer.permit(:account_update,
      keys: [:password, :password_confirmation, :current_password]
    )
  end 

  def current_user_can_edit?(model)
    if !user_signed_in?
      false
    elsif model.user == current_user
      true
    elsif model.try(:event).present? && model.event.user == current_user
      true
    else
      false
    end
  end

  add_flash_types :danger, :info, :warning, :success, :messages
end
