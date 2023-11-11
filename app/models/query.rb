class Query < ApplicationRecord
  belongs_to :user
  belongs_to :address
  belongs_to :currentheating
end
