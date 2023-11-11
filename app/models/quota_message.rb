class QuotaMessage < ApplicationRecord
  belongs_to :user
  belongs_to :company_contact
end
