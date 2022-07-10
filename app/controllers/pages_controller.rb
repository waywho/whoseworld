class PagesController < ApplicationController
  before_action :set_page, only: %i[ show edit update destroy ]

  # GET /pages
  def index
    @pages = Current.tenant.pages.all
  end

  # GET /pages/1
  def show
  end

  def landing
    render "#{Current.tenant.slug}/landing", layout: 'home'
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
