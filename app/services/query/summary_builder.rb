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

  CURRENT_HEATING_CO2 = {
    "direct" => 0.3,
    "oil" => 0.36,
    "gas" => 0.2,
    "district" => 0.15
  }.freeze

  PLANNED_HEATING_CO2 = {
    "heatpump" => 0.1,
    "geothermal" => 0.05,
    "water_heatpump" => 0.08
  }.freeze

  INVESTMENT_COSTS = {
    "heatpump" => 2500,
    "geothermal" => 27500,
    "water_heatpump" => 15000
  }.freeze

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

    query.planned_heatings.each do |heating|
      # check that the heating type is in the list of current heating solutions
      total_cost += heating.cost || 0
      total_energy += heating.energy.presence || 0

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

    total_co2_reduction = PLANNED_HEATING_SOLUTIONS.map do |solution|
      current_co2 = query.planned_heatings.sum { |h| CURRENT_HEATING_CO2[h.heating_unit.heating_type] * h.energy }
      planned_co2 = PLANNED_HEATING_CO2[solution] * total_energy
      co2_reduction = current_co2 - planned_co2
      [solution, co2_reduction]
    end.to_h

    roi = total_savings_by_solution.map do |solution, savings|
      average_investment_cost = INVESTMENT_COSTS[solution]
      years_to_roi = average_investment_cost / savings
      [solution, years_to_roi]
    end.to_h

    summary_data = PLANNED_HEATING_SOLUTIONS.map do |solution|
      {
        "name" => solution,
        "total_savings" => total_savings_by_solution[solution],
        "total_co2_reduction" => total_co2_reduction[solution],
        "roi" => roi[solution]
      }
    end

    self.result = {
      "data" => summary_data,
      "total_cost" => total_cost,
      "total_energy" => total_energy
    }
  end
end
