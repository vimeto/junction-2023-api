class Query::SummaryBuilder
  MAX_HEATPUMP_SAVINGS = 1000
  MAX_GEOTHERMAL_SAVINGS = 3000
  MAX_WATER_HEATPUMP_SAVINGS = 1500

  SAVINGS = [
    MAX_HEATPUMP_SAVINGS,
    MAX_GEOTHERMAL_SAVINGS,
    MAX_WATER_HEATPUMP_SAVINGS
].freeze

  PLANNED_HEATING_SOLUTIONS = [
    "heatpump",
    "geothermal",
    "water_heatpump"
  ].freeze


  CURRENT_HEATING_SOLUTIONS = [
    "direct",
    "oil",
    "gas",
    "district"
  ].freeze

  CURRENT_HEATING_SOLUTIONS_FACTOR = [
    [0.4, 0.8, 0.6],
    [0.2, 0.4, 0.3],
    [0.2, 0.4, 0.3],
    [0.15, 0.3, 0.2]
  ]

  attr_reader :result

  def self.call(*args)
    model = new(*args).call
    model
  end

  def initialize(query)
    self.query = query
  end

  def call
    calculate_summary
    self
  end

  private

  attr_accessor :query
  attr_writer :result

  def calculate_summary
    total_savings = [0, 0, 0]
    total_cost = 0
    total_energy = 0

    query.heatings.each do |heating|
      # check that the heating type is in the list of current heating solutions
      total_cost += heating.cost
      total_energy += heating.energy

      if CURRENT_HEATING_SOLUTIONS.include?(heating.heating_unit.heating_type)
        # get index of current heating solution
        i = CURRENT_HEATING_SOLUTIONS.index(heating.heating_unit.heating_type)
        # get all factors for current heating solution to the planned heating solutions
        factors = CURRENT_HEATING_SOLUTIONS_FACTOR[i]

        factors.each_with_index do |factor, index|
          savings = [heating.cost * factor, SAVINGS[index]].min
          total_savings[index] += savings
        end
      end
    end

    total_savings_by_solution = total_savings.map.with_index do |saving, index|
      [PLANNED_HEATING_SOLUTIONS[index], saving]
    end.to_h

    self.result = {
      total_savings: total_savings_by_solution,
      total_cost: total_cost,
      total_energy: total_energy
    }
  end
end
