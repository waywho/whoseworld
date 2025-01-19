module Menuable
  extend ActiveSupport::Concern

  included do
    has_one :menu_item, as: :record, dependent: :destroy
  end

  private

  def add_to_menu
    create_menu_item(title: title, site_id: site_id, row_order: row_order)
  end
end
