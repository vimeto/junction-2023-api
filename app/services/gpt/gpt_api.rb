class Gpt::GptApi
  API_ENDPOINT = "https://api.openai.com/v1/chat/completions"
  MODEL = "gpt-4-1106-preview"

  def self.call(*args)
    new(*args).call
  end

  def initialize(prompt, opts = {})
    self.prompt = prompt
  end

  def call
    start_time = Time.current
    results = HTTParty.post(API_ENDPOINT, headers: http_headers, body: params.to_json, timeout: 400)
    log "GPT API call took #{Time.current - start_time} seconds"

    results
  end

  private

  attr_accessor :prompt

  def http_headers
    {
      "Authorization" => "Bearer #{ENV["OPENAI_API"]}",
      "Content-Type" => "application/json"
    }
  end

  def params
    {
      model: MODEL,
      messages: [
        {role: "user", content: prompt}
      ],
      temperature: 0.0,
      max_tokens: 4000,
      top_p: 1.0,
      frequency_penalty: 0.0,
      presence_penalty: 0.0
    }
  end

  def log(msg)
    message = format("%<class_name>s#%<method_name>s: %<msg>s",
      class_name: self.class.name,
      method_name: caller_locations(1, 1)[0].label,
      msg: msg)
    Rails.logger.info message
  end
end
