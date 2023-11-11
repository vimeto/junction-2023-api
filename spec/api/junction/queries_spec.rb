require 'rails_helper'

describe Junction::Queries do
  let(:user) { create(:user) }

  describe 'GET /queries' do
    it 'returns all queries' do
      get "/api/v1/queries", params: { format: :json }
      response_body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(response_body).to eq([])
    end
  end

  describe 'POST /queries' do
    let(:query_params) do
      {
        name: "default name",
        occupants: 4,
        budget: 1000.0,
        content: 'New Query',
        due_date: DateTime.now,
        current_heatings: [
          {
            heating_type: 'direct',
            energy: 500,
            cost: 2000,
            state: 'installed',
            percentage: 60
          }
        ],
        address: {
          street: 'Rue de la Paix',
          city: 'Paris',
          zipcode: '75000'
        }
      }
    end

    it 'creates a new query' do
      post "/api/v1/queries", params: query_params

      response_body = JSON.parse(response.body)

      expect(response.status).to eq(201)
      expect(response_body['occupants']).to eq(query_params[:occupants])
      expect(response_body['budget']).to eq(query_params[:budget])
      expect(response_body['content']).to eq(query_params[:content])
      expect(response_body['name']).to eq(query_params[:name])

      query = Query.find_by(id: response_body['id'])
      expect(query).to be_present

      expect(query.address.street).to eq(query_params[:address][:street])
      expect(query.heatings.count).to eq(1)
    end
  end

  describe 'PUT /queries/:id' do
    let(:query) { create(:query, user: user) } # Assuming you have a Query factory
    let(:update_params) { { budget: 1500.0, content: 'Updated Query' } }

    it 'updates an existing query' do
      put "/queries/#{query.id}", update_params
      expect(last_response.status).to eq(200)
      # Add more expectations here
    end
  end
end
