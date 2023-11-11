class Query::IntelligentSummaryBuilder
  attr_reader :result

  def self.call(*args)
    model = new(*args).call
    model
  end

  def initialize(query, summary)
    self.query = query
    self.summary = summary
  end

  def call
    calculate_summary
    self
  end

  private

  attr_accessor :query, :summary
  attr_writer :result

  def calculate_summary
    format = """
    Hi! We are thinking about a home energy investment, and I'd like to hear your short conclusion from this data!

    The budget for this energy investment is %s, there are %s people in the household. The house is %s sqm, and the energy consumption is %s kWh per year. Currently, we use %s to heat the house, and here are some details about possible methods to save:

    1) To use a heat pump. This would result in a %s € save yearly, and the investment would pay itself back in %s years. The investment would be %s €.
    2) To use geothermal energy. This would result in a %s € save yearly, and the investment would pay itself back in %s years. The investment would be %s €.
    3) To use a water heat pump. This would result in a %s € save yearly, and the investment would pay itself back in %s years. The investment would be %s €.

    Please give me a short conclusion from this data (max 1 very short paragraph). Do not suggest ANYTHING, and stick to the data. No need to repeat the data, just point out the most important and interesting things.
    """

  input_message = format % [
      query.budget,
      query.occupants,
      query.houseSqm,
      summary["total_energy"],
      query.heatings.map { |heating| heating.heating_unit[:heating_type] }.join(", "),
      summary["data"][0]["total_savings"]&.round(1),
      summary["data"][0]["roi"]&.round(1),
      summary["data"][0]["average_price"]&.round(1),
      summary["data"][1]["total_savings"]&.round(1),
      summary["data"][1]["roi"]&.round(1),
      summary["data"][1]["average_price"]&.round(1),
      summary["data"][2]["total_savings"]&.round(1),
      summary["data"][2]["roi"]&.round(1),
      summary["data"][2]["average_price"]&.round(1)
    ]

    parsed_response = Gpt::GptApi.call(input_message).parsed_response
    parsed_response = JSON.parse(parsed_response.body) if parsed_response.is_a?(String)

    response = parsed_response.dig("choices", 0, "message", "content")

    self.result = response
  end
end
