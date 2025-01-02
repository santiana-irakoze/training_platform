class ResponsesController < ApplicationController
  before_action :set_test

  def new
    @questions = @test.questions
    @responses = @questions.map { |q| Response.new(test: @test, question: q) }
  end

  def create
    @test = Test.find(params[:test_id])
    original_duration = @test.duration # Store the original duration

    # Calculate actual duration in seconds
    start_time = Time.parse(session[:test_start_time].to_s)
    actual_duration = (Time.current - start_time).to_i  # Convert to integer seconds

    # Ensure we have answers
    unless params[:answers]
      redirect_to test_path(@test), alert: "No answers submitted!"
      return
    end

    total_questions = @test.questions.count
    correct_answers = 0

    # Process each question's response
    params[:answers].each do |question_id, answer|
      question = Question.find(question_id)
      # Case insensitive comparison and strip whitespace
      is_correct = answer.strip.downcase == question.answer.strip.downcase
      correct_answers += 1 if is_correct

      # Create response record
      Response.create!(
        test: @test,
        question_id: question_id,
        chosen_option: answer,
        is_correct: is_correct
      )
    end

    # Calculate score as percentage
    score = total_questions.zero? ? 0 : ((correct_answers.to_f / total_questions) * 100).round

    # Update test with score, date, status, and time taken (but preserve original duration)
    if @test.update(
      score: score,
      date: Time.current,
      status: "taken",
      user: current_user,
      time_taken: actual_duration  # Use new column instead of duration
    )
      # Clear the start time from session
      session.delete(:test_start_time)
      redirect_to test_path(@test), notice: "Test completed! Your score: #{score}%"
    else
      redirect_to test_path(@test), alert: "Error saving test results!"
    end
  end

  private

  def set_test
    @test = Test.find(params[:test_id])
  end
end
