# app/api/api.rb
module Api
  class Base < Grape::API
    include Junction::Base
    version 'v1', using: :path
    format :json

    mount Junction::Home
    mount Junction::Welcome
    mount Junction::Queries
    mount Junction::Offers

    add_swagger_documentation
  end
end
