# app/api/my_app/my_resource.rb
module Junction
  class Queries < Grape::API
    before do
      authenticate_user!
    end

    resource :queries do
      desc 'Get all queries'
      get do
        current_user.queries
      end

      desc 'Get a query'
      params do
        requires :id, type: Integer, desc: 'Query id'
      end
      route_param :id do
        get do
          query = current_user.queries.find(params[:id])
          error!('Not Found', 404) if !query
          query
        end
      end

      desc 'Create a query'
      params do
        requires :occupants, type: Integer, desc: 'Number of occupants'
        requires :budget, type: Float, desc: 'Budget'
        requires :content, type: String, desc: 'Content'
        group :address, type: Hash do
          optional :street, type: String, desc: 'Street name'
          optional :city, type: String, desc: 'City name'
          optional :zipcode, type: String, desc: 'Zip Code'
        end
        requires :current_heatings, type: Array do
          requires :heating_type, type: String, desc: 'Heating type'
          optional :energy, type: Float, desc: 'Energy'
          optional :cost, type: Float, desc: 'Cost'
          optional :state, type: String, desc: 'State'
          optional :percentage, type: Float, desc: 'Percentage'
        end
        requires :due_date, type: DateTime
      end

      post do
        address = Address.where({
          street: params.dig(:address, :street),
          city: params.dig(:address, :city)
        }).first || Address.create({
          street: params.dig(:address, :street),
          city: params.dig(:address, :city),
          zipcode: params.dig(:address, :zipcode)
        })

        query = current_user.queries.new({
          budget: params[:budget],
          content: params[:content],
          due_date: params[:due_date],
          address: address
        })

        params.current_heatings&.each do |heating|
          state = heating[:state].presence || "planned"
          heating_unit = HeatingUnit.where({
            state: state,
            heating_type: heating[:heating_type]
          }).first || HeatingUnit.create({
            state: state,
            heating_type: heating[:heating_type]
          })

          heating = heating_unit.heatings.new({
            energy: heating[:energy],
            cost: heating[:cost],
            percentage: heating[:percentage]
          })
          query.heatings << heating
        end

        if query.save
          query
        else
          error!(query.errors.full_messages.join(", "), 400)
        end
      end

      desc 'Update a query'
      params do
        requires :id, type: Integer, desc: 'Query id'
        requires :user_id, type: Integer, desc: 'User id'
        requires :budget, type: Float, desc: 'Budget'
        requires :content, type: String, desc: 'Content'
      end

      put ':id' do
        query = Query.find(params[:id])
        error!('Not Found', 404) unless query

        if query.update({
          user_id: params[:user_id],
          budget: params[:budget],
          content: params[:content]
        })
          query
        else
          error!(query.errors.full_messages.join(", "), 400)
        end
      end
    end
  end
end
