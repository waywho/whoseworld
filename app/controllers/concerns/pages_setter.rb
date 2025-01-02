module PagesSetter
  extend ActiveSupport::Concern

  private

  def set_pages(site)
    if site.layout_style == :one_page
      site.pages.menu_pages.includes(:medias, :galleries).rank(:row_order)
    else
      site.pages.feature.rank(:row_order)
    end
  end
end
