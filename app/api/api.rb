# app/api/api.rb
module Api
  class Base < Grape::API
    version 'v1', using: :path
    format :json

    mount Junction::Welcome

    add_swagger_documentation
  end
end
