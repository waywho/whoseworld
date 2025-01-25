class BURM::SignupsController < SiteBaseController
  before_action :set_musical
  before_action :set_signup, only: %i[edit update destroy]

  def new
    @signup = @musical.signups.build
    @signup.build_person
  end

  def create
    @signup = @musical.signups.build(signup_params)

    if @signup.save
      render :thank_you, status: :created
    else
      render :new, alert: :cannot_signup, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @signup.update(signup_params)
      render :thank_you, status: :ok
    else
      render :edit, alert: :cannot_update, status: :unprocessable_entity
    end
  end

  def destroy
    @signup.update(cancelled: true)

    render :thank_you, status: :no_content
  end

  private

  def set_musical
    @musical = BURM::Musical.friendly.find(params[:musical_id])
  end

  def set_signup
    @signup = BURM::Signup.find(params[:id])
  end

  def signup_params
    params.require(:burm_signup).permit(:burm_person_id, :burm_role_id, :burm_musical_id,
      :alternative_role_id, :cancelled, :cancelled_at, :cancellation_reason,
      person_attributes: %i[first_name last_name email])
  end
end
