class BURM::SignupsController < SiteBaseController
  before_action :set_musical
  before_action :check_signup_open, only: %i[new create]
  before_action :set_signup, only: %i[show edit update destroy]

  def show
    @status = params[:status]

    if @status == "updated" || @status == "created"
      render :thank_you, status: :ok
    end
  end

  def new
    @signup = @musical.signups.build
    @signup.build_person
  end

  def create
    @signup = @musical.signups.build(signup_params)

    if @signup.save
      redirect_to burm_signup_path(@musical, @signup, status: :created)
    else
      flash.now[:alert] = t(".cannot_signup", error: @signup.errors.full_messages.to_sentence)

      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @signup.update(signup_params)
      @result = :updated
      redirect_to burm_signup_path(@musical, @signup, status: :updated)
    else
      flash.now[:alert] = t(".cannot_update", error: @signup.errors.full_messages.to_sentence)
      render :edit, status: :unprocessable_entity
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

  def check_signup_open
    return if @musical.signup_open? || current_user&.admin?

    render :not_open, status: :forbidden
  end

  def set_signup
    @signup = BURM::Signup.find(params[:id])
  end

  def signup_params
    params.require(:burm_signup).permit(:burm_person_id, :burm_role_id, :burm_musical_id,
      :alternative_role_id, :cancelled, :cancelled_at, :cancellation_reason, :role_sharing, :family_friends_watching, :commit_to_pay, :comments,
      person_attributes: %i[first_name last_name email voice_type agree_to_emails])
  end
end
