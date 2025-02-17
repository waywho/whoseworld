class BURM::NewslettersController < ApplicationController
  before_action :set_person, only: %i[edit unsubscribe]

  def new
    @person = BURM::Person.new

    render :new
  end

  def edit
  end

  def create
    @person = BURM::Person.new(mailing_params)

    if @person.save
      BURM::NewslettersMailer.with(person: @person).new_subscription.deliver_later
      render :created
    else
      render :new
    end
  end

  def confirm
    logger.info "Confirming person with token: #{params[:token]}"
    @person = BURM::Person.find_by(confirmation_token: params[:token])

    @person.confirm!
    @person.subscribe!
    render :confirmed
  end

  def unsubscribe
    @person.unsubscribe!

    render :unsubscribed
  end

  private

  def set_person
    @person = BURM::Person.find(params[:id])
  end

  def mailing_params
    params.require(:burm_person).permit(:first_name, :last_name, :email,  :agree_to_terms, :agree_to_emails)
  end
end
