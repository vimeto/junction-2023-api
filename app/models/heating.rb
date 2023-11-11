class Heating < ApplicationRecord
  belongs_to :heating_unit

  has_many :planned_queries, class_name: 'Query', join_table: :planned_heatings
  has_many :tendering_queries, class_name: 'Query', join_table: :tendering_heatings
end
