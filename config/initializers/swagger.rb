# frozen_string_literal: true

if defined?(GrapeSwaggerRails)
  GrapeSwaggerRails.options.url = "/api/v1/swagger_doc"
  GrapeSwaggerRails.options.hide_url_input = true
  GrapeSwaggerRails.options.hide_api_key_input = true
  GrapeSwaggerRails.options.app_name = "Junction"
  GrapeSwaggerRails.options.doc_expansion = "none"

  GrapeSwaggerRails.options.api_auth = "token"
  GrapeSwaggerRails.options.api_key_name = "Authorization"
  GrapeSwaggerRails.options.api_key_type = "header"

  GrapeSwaggerRails.options.before_action do
    GrapeSwaggerRails.options.app_url = request.protocol + request.host_with_port
  end
end
