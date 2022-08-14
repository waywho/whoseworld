class PagesController < ApplicationController
  before_action :set_page, only: %i[ show edit update destroy ]
  layout 'home'

  # GET /pages
  def index
    @pages = Current.tenant.pages.rank(:row_order).all
  end

  # GET /pages/1
  def show
  end

  def landing
    if Rails.env.production? && !Current.user&.admin?
      render "pages/landing", layout: 'application'
    else
      render "#{Current.tenant.slug}/landing"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Current.tenant.pages.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.require(:page).permit(:title, :landing)
    end
end
