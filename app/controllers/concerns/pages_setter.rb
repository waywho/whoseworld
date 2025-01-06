module PagesSetter
  extend ActiveSupport::Concern

  private

  def set_pages(site)
    if site.one_page?
      site.pages.menu.includes(:medias, :galleries).rank(:row_order)
    else
      site.pages.feature.rank(:row_order)
    end
  end
end
