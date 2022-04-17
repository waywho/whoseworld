class Account < ApplicationRecord
    validates_presence_of :name
    validate :subdomain_or_domain_cannot_be_nil


    private

    def subdomain_or_domain_cannot_be_nil
        if !subdomain.present? && !domain.present?
            errors.add(:base, 'domain or subdomain must not be empty.')

            %i[subdomain domain].each do |field|
                errors.add(field, "#{field} must not be empty") unless self[field].present?
            end
        end
    end
end
