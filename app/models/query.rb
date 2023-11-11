class Query < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :heatings
end
