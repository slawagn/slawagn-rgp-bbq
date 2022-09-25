class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def pundit_user
    EventPolicy::UserWithPincode.new(current_user, cookies.permanent["event_#{@event&.id}_pincode"])
  end

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


  private

  def user_not_authorized
    flash[:alert] = t('pundit.not_authorized')
    redirect_to(request.referrer || root_path)
  end
end
