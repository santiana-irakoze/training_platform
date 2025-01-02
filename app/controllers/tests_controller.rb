class TestsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: [:admin_index]
  before_action :set_test, only: [:show]

  def index
    @tests = Test.all
  end

  def show
    @attempted = current_user.tests.exists?(@test.id)
  end

  def new
    @test = Test.find(params[:test_id])
    Rails.logger.debug "Test object: #{@test.inspect}"
    Rails.logger.debug "Test duration: #{@test.duration}"
    @questions = @test.questions if @test.questions.present?

    # Set start time when test begins
    session[:test_start_time] = Time.current
  end

  def create
    @test = Test.find(params[:id])
    attempt = @test.dup # Duplicate test as an attempt
    attempt.user = current_user
    attempt.date = Time.now
    attempt.status = "taken"
    attempt.duration = original_duration # Ensure we keep the original duration

    if attempt.save
      params[:answers].each do |question_id, chosen_option|
        question = Question.find(question_id)
        is_correct = question.answer == chosen_option

        Response.create!(
          test_id: attempt.id,
          question_id: question.id,
          chosen_option: chosen_option,
          is_correct: is_correct
        )
      end
      redirect_to test_path(attempt), notice: 'Test started!'
    else
      redirect_to tests_path, alert: "Error starting test."
    end
  end

  def admin_index
    @tests = Test.all
  end

  private

  def test_params
    params.require(:test).permit(:Name, :duration, :score, :format, :status)
  end

  def set_test
    @test = Test.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to tests_path, alert: "Test not found."
  end

  def check_admin
    unless current_user.admin?
      redirect_to root_path, alert: "Access restricted to admins only."
    end
  end
end
