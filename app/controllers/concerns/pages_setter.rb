module PagesSetter
  extend ActiveSupport::Concern

  private

  def set_pages
    @pages = if Current.tenant&.template_style == "one_page"
      Current.tenant.pages.menu_pages.includes(:medias, :galleries).rank(:row_order)
    elsif @site
      @site.pages&.feature.rank(:row_order)
    elsif Current.tenant
      Current.tenant.pages&.feature.rank(:row_order)
    end
  end
end
