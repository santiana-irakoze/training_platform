class PagesController < ApplicationController
  def dashboard_admins
    @admins = User.where(status: 'Admin')
  end
  def dashboard_students
    @students = User.where(status: 'Student')
    @tests = current_user.tests 
  end
end
