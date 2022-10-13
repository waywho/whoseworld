class Media < ApplicationRecord
  belongs_to :page
  belongs_to :site, optional: true

  def self.types
    %i[video audio]
  end
end
