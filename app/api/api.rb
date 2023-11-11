# app/api/api.rb
module Api
  class Base < Grape::API
    include Junction::Base
    version 'v1', using: :path
    format :json

    mount Junction::Welcome
    mount Junction::Queries

    add_swagger_documentation
  end
end
