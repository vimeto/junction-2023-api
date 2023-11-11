class Query < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :heatings

  serialize :summary, JSON
end
