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

      desc "Start contractor rendering"
      params do
        requires :id, type: Integer, desc: 'Query id'
        requires :heating_unit_ids, type: Array, desc: 'Heating unit ids'
      end

      post ':id/start_contractor_rendering' do
        query = current_user.queries.where(id: params[:id]).includes(heatings: :heating_unit).first
        error!('Not Found', 404) if !query

        heating_unit_ids = query.heatings.current.map(&:heating_unit_id) & params[:heating_unit_ids].map(&:to_i)
        heatings = Heating.where(heating_unit_id: heating_unit_ids)

        if heatings.empty?
          error!("No heating units found", 400)
        end

        if query.save
          heatings.each do |heating|
            heating.update(state: "tendered")
          end

          query.save!

          query
        else
          error!(query.errors.full_messages.join(", "), 400)
        end
      end

      desc 'Create a query. Returns a summary { total_savings:, total_cost:, total_energy: } in summary'
      params do
        requires :occupants, type: Integer, desc: 'Number of occupants'
        requires :budget, type: Float, desc: 'Budget'
        optional :name, type: String, desc: 'Name'
        optional :houseSqm, type: Float, desc: 'House square meters'
        requires :content, type: String, desc: 'Content'
        group :address, type: Hash do
          optional :street, type: String, desc: 'Street name'
          optional :city, type: String, desc: 'City name'
          optional :zipcode, type: String, desc: 'Zip Code'
        end
        requires :current_heatings, type: Array do
          requires :heating_type, type: String, desc: 'Heating type (gas/oil/wood/pellets/heat pump/solar/other))'
          optional :energy, type: Float, desc: 'Energy (kWh/v))'
          optional :cost, type: Float, desc: 'Cost (€/v)'
          optional :state, type: String, desc: 'State (planned/installed)'
          optional :percentage, type: Float, desc: 'Percentage (%)'
        end
        requires :due_date, type: String
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
          due_date: DateTime.parse(params[:due_date]),
          occupants: params[:occupants],
          name: params[:name],
          address: address,
          houseSqm: params[:houseSqm]
        })

        params["current_heatings"]&.each do |heating|
          heating_unit = HeatingUnit.where({
            heating_type: heating[:heating_type]
          }).first || HeatingUnit.create({
            heating_type: heating[:heating_type]
          })

          heating = heating_unit.heatings.create({
            energy: heating[:energy],
            cost: heating[:cost],
            percentage: heating[:percentage],
            state: "current"
          })
          query.heatings << heating
        end

        if query.save
          summary_builder = Query::SummaryBuilder.call(query)
          query.update({
            summary: summary_builder.result
          })
          { query: query.as_json(include_heating_units: true) }
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
