class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :owns_event?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update,
      keys: [:password, :password_confirmation, :current_password]
    )
  end 

  def owns_event?(event)
    user_signed_in? && event.user == current_user
  end

  add_flash_types :danger, :info, :warning, :success, :messages
end
