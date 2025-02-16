class BURM::MailingsController < ApplicationController
  before_action :set_person, only: %i[edit confirm unsubscribe]

  def new
    @person = BURM::Person.new

    render :new
  end

  def edit
  end

  def create
    @person = BURM::Person.new(mailing_params)

    if @person.save
      render :created
    else
      render :new
    end
  end

  def confirm
    @person.confirm!

    render :confirmed
  end

  def unsubscribe
    @person.unsubscribe!
    debugger
    render :unsubscribed
  end

  private

  def set_person
    @person = BURM::Person.find(params[:id] || params[:burm_mailing_id])
  end

  def mailing_params
    params.require(:burm_person).permit(:first_name, :last_name, :email,  :agree_to_terms, :agree_to_emails)
  end
end
