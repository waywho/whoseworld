module Addressable
  extend ActiveSupport::Concern

  included do
    has_one :address, as: :addressable, class_name: "Address", dependent: :destroy
    accepts_nested_attributes_for :address, allow_destroy: true, reject_if: :all_blank
    after_commit :create_address, if: :saved_change_to_location?
  end

  private

  def create_address
    return unless location.present?

    build_address(search_address.slice("address", "display_name", "lat", "lon", "boundingbox"))
    save
  end

  def search_address
    res = open_street_client.search(q: location, format: "json", addressdetails: "1", accept_language: "en")

    if res.one?
      res.first
    else
      res.find { |r| r["type"] == "primary" } || res.first
    end
  end

  def open_street_client
    @open_street_client ||= OpenStreetMap::Client.new
  end
end
