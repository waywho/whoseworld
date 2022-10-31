class PagesController < ApplicationController
  before_action :set_page, only: %i[ show edit update destroy ]
  before_action :set_pages, only: :landing
  layout "home"

  # GET /pages
  def index
    @pages = Current.tenant.pages.includes(:galleries, :medias).rank(:row_order).all
  end

  # GET /pages/1
  def show
  end

  def landing
    if Current.tenant&.public? || current_user&.admin?
      render "#{Current.tenant.slug}/landing"
    else
      render "pages/landing", layout: "application"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Current.tenant.pages.friendly.find(params[:id])
    end

    def set_pages
      @pages = if Current.tenant&.template_style == "one_page"
        Current.tenant.pages.menu_pages.includes(:medias, :galleries).rank(:row_order)
      else
        Current.tenant.pages.feature.rank(:row_order)
      end
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.require(:page).permit(:title, :landing)
    end
end
