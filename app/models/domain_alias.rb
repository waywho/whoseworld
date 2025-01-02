class DomainAlias < ApplicationRecord
  nilify_blanks
  
  # Associations
  belongs_to :site
end
