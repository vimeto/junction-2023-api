class Query < ApplicationRecord
  belongs_to :user
  belongs_to :address
  has_many :heatings

  serialize :summary, JSON

  def as_json(include_heating_units: false)
    hash = {
      id: id,
      content: content,
      user_id: user_id,
      name: name,
      budget: budget,
      address_id: address_id,
      occupants: occupants,
      due_date: due_date,
      summary: summary,
      houseSqm: houseSqm
    }

    if include_heating_units
      hash.merge!({
        heating_units: heatings.map { |heating| heating.heating_unit.attributes }
      })
    end

    hash
  end
end
