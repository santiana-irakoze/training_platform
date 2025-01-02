class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :status])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :status])
  end

  def check_admin
    unless current_user&.status == 'Admin'
      redirect_to dashboard_students_path, alert: "Access denied. Admin only area."
    end
  end

  def check_student
    unless current_user&.status == 'Student'
      redirect_to dashboard_admins_path, alert: "Access denied. Student only area."
    end
  end
end
