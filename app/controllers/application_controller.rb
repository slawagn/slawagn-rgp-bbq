class ApplicationController < ActionController::Base
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
      keys: [:name]
    )

    devise_parameter_sanitizer.permit(:account_update,
      keys: [:password, :password_confirmation, :current_password]
    )
  end 

  add_flash_types :danger, :info, :warning, :success, :messages
end
