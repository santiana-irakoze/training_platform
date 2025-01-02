class UsersController < ApplicationController
  before_action :check_admin

  def destroy
    @user = User.find(params[:id])
    if @user.status == "Student"
      @user.destroy
      redirect_to dashboard_admins_path, notice: 'Student was successfully removed.'
    else
      redirect_to dashboard_admins_path, alert: 'Cannot delete admin users.'
    end
  end
end
