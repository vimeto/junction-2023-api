class OfferDiscussion < ApplicationRecord
  belongs_to :query
  belongs_to :company_contact

  has_many :offer_messages, dependent: :destroy
end
