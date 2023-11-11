class CompanyContact < ApplicationRecord
  belongs_to :company

  has_many :offer_discussions, dependent: :destroy
end
