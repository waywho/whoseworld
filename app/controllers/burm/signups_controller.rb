class BURM::SignupsController < ApplicationController
  before_action :set_musical
  before_action :set_signup, only: %i[edit update destroy]

  def new
  end

  def create
    render :thank_you, status: :created
  end

  def edit
  end

  def update
  end

  def destroy
    render :thank_you, status: :no_content
  end

  private

  def set_musical
    @musical = BURM::Musical.friendly.find(params[:musical_id])
  end

  def set_signup
    @signup = BURM::Signup.find(params[:id])
  end
end
