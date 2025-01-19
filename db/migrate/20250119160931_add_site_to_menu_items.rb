class AddSiteToMenuItems < ActiveRecord::Migration[7.2]
  def change
    Page.where(kind: :menu).each do |page|
      page.create_menu_item(site_id: page.site_id, name: page.title, row_order: page.row_order)
    end
  end
end
