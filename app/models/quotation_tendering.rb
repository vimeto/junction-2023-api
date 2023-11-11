class QuotationTendering < ApplicationRecord
  belongs_to :query
  has_many :selected_heating_units, class_name: 'HeatingUnit'
  has_many :quota_discussions
end
