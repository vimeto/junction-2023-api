class Query < ApplicationRecord
  belongs_to :user
  belongs_to :address

  has_many :planned_heatings, class_name: 'Heating', join_table: :planned_heatings
  has_many :tendering_heatings, class_name: 'Heating', join_table: :tendering_heatings

  serialize :summary, JSON
end
