class TestsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :create]
  before_action :check_admin, only: [:admin_index]


  def index
    @tests = Test.where(user_id: current_user.id)
  end


  def show
    @test = Test.find(params[:id])
  end

  def new
    @test = Test.new
    @questions = Question.all
  end

  def create
    @test = Test.new(test_params)
    @test.user_id = current_user.id
    if @test.save
      redirect_to test_path(@test), notice: 'Test started!'
    else
      render :new, alert: "Error creating test."
    end
  end


  # def update
  #   @test = Test.find(params[:id])
  #   if @test.update(test_params)
  #     redirect_to @test, notice: 'Test results updated successfully.'
  #   else
  #     render :edit
  #   end
  # end


  def admin_index
    @tests = Test.all
  end

  private

  def test_params
    params.require(:test).permit(:score, :duration, :date)
  end

  def check_admin
    unless current_user.admin?
      redirect_to root_path, alert: "Access restricted to admins only."
    end
  end
end
