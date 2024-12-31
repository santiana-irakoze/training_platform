class ResponsesController < ApplicationController
  def new
    @questions = Question.all
    @responses = @questions.map { |q| Response.new(test: @test, question: q) }
  end

  def create
    responses = params[:responses].map do |response_params|
      Response.new(response_params.permit(:question_id, :test_id, :reponse_donnee))
    end

    if responses.all?(&:save)
      correct_count = responses.count(&:correcte?)
      @test.update(score: correct_count)

      redirect_to test_path(@test), notice: "Test completed with #{correct_count} correct responses!"
    else
      render :new, alert: "Error saving responses."
    end
  end

  private

  def set_test
    @test = Test.find(params[:test_id])
  end
end
