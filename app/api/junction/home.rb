# app/api/my_app/my_resource.rb
module Junction
  class Home < Grape::API
    before do
      authenticate_user!
    end

    resource :home do
      desc "Return offers for the current user"
      get do
        offer_ids = [1, 2, 3, 4]
        company_names = ["Heat pump", "Geothermal", "Water heat pump", "District heating"]
        answers = [[3, 4], [1, 2], [1, 2], [9, 14]]

        offers = offer_ids.map.with_index do |offer_id, index|
          {
            id: offer_id,
            company_name: company_names[index],
            answers: { answered: answers[index][0], total: answers[index][1] }
          }
        end

        { offers: offers }
      end
    end
  end
end
