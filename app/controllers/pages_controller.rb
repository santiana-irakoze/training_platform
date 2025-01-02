class PagesController < ApplicationController
  before_action :set_tests, only: [:dashboard_students, :preview, :historic]
  before_action :check_student, only: [:dashboard_students, :preview, :historic]
  before_action :check_admin, only: [:dashboard_admins, :admin_students, :admin_statistics]

  # Main dashboard for students
  def dashboard_students
    @students = User.where(status: 'Student')
    @tests = Test.all
  end

  # Preview tab (default)
  def preview
    @tests = Test.all  # Show all tests instead of just available ones
    @taken_test_ids = current_user.tests.pluck(:id)  # Get IDs of tests taken by user
    render partial: "pages/preview", locals: { tests: @tests }, layout: false
  end

  # Historic tab
  def historic
    @completed_tests = Test.where(user: current_user, status: 'taken').order(date: :desc)
    render partial: "pages/historic", locals: { tests: @completed_tests }, layout: false
  end

  def dashboard_admins
    @admins = User.where(status: 'Admin')
    @students = User.where(status: 'Student').order(:email)
    @tests = Test.all
    render 'pages/dashboard_admins'
  end

  def admin_students
    @students = User.where(status: 'Student').order(:email)
    render partial: "pages/admin_students", locals: { students: @students }, layout: false
  end

  def admin_statistics
    @students = User.where(status: 'Student')
    @tests = Test.all
    render partial: "pages/admin_statistics", layout: false
  end

  private

  def set_tests
    @tests = Test.all
  end

  def set_taken_tests
    @taken_test_ids = current_user.tests.where(status: 'taken').pluck(:id)
  end
end
