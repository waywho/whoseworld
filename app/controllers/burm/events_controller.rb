class BURM::EventsController < SiteBaseController

  def index
    @musicals = BURM::Musical.all.order(:start_at)
  end
end
