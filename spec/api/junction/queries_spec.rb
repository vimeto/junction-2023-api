require 'rails_helper'

describe Junction::Queries do
  let(:user) { create(:user) }
  let(:query) { create(:query, user: user) }
  let(:heating_unit) { create(:heating_unit) }

  # before do
  #   allow_any_instance_of(Junction::Queries).to receive(:current_user).and_return(user)
  # end

  describe 'GET /queries' do
    it 'returns all queries' do
      get "/api/v1/queries", params: { format: :json }
      response_body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(response_body).to eq([])
    end
  end

  describe 'POST /queries/:id/start_contractor_rendering' do
    let(:contractor_rendering_params) do
      {
        id: query.id,
        heating_unit_ids: [heating_unit.id]
      }
    end

    it 'starts contractor rendering for a query' do
      query.planned_heatings << create(:heating, heating_unit: heating_unit)

      post "/api/v1/queries/#{query.id}/start_contractor_rendering", params: contractor_rendering_params

      response_body = JSON.parse(response.body)
      query.reload

      expect(response.status).to eq(201)
      expect(query.tendering_heatings).to be_present
      expect(query.tendering_heatings.map(&:heating_unit_id)).to include(heating_unit.id)
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
      expect(query.planned_heatings.count).to eq(1)
    end
  end
end
