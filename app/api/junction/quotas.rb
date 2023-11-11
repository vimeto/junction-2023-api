# app/api/my_app/my_resource.rb
module Junction
  class Offers < Grape::API
    before do
      authenticate_user!
    end

    resource :offers do
      desc "Get an offer with id"
      params do
        requires :id, type: Integer, desc: "Offer id."
      end
      get ':id' do
        data = {
          id: params[:id],
          name: "Heatpump 2023",
          company: {
            contact_person: {
              name: "John Doe",
              email: "joni.taikina@gmale.com",
              phone: "0401234567"
            },
            name: "Junction Ltd.",
            address: {
              street: "Kumpulantie 3",
              city: "Helsinki",
              postal_code: "00520",
            },
            url: "http://www.junction.fi"
          },
          offer: {
            name: "Heatpump 2023",
            product: "Mitsubishi 2023",
            price: 1234,
            due_date: "2026-11-25",
            annual_savings: 4321,
            annual_emission_savings: 10101,
            estimated_payback_time: 3.5,
          },
          messages: [
            {
              id: 1,
              user: "root@root.fi",
              message: "Hello! My customer would be interested in buying a heat pump for you. What is the price for a 1000kW heat pump?"
            },
            {
              id: 2,
              user: "joni.taikina@gmale.com",
              message: "Hello! The price for a 1000kW heat pump is 1234€."
            },
            {
              id: 3,
              user: "root@root.fi",
              message: "Hello! That is a bit too expensive. Can you do it for 1000€?"
            },
            {
              id: 4,
              user: "joni.taikina@gmale.com",
              message: "Hello! I cannot do it for 1000€, but I can do it for 1100€."
            },
            {
              id: 5,
              user: "root@root.fi",
              message: "Hello! Thanks, I'll be in touch"
            }
          ]
        }
      end

      desc "Get all outstanding offers for a query"
      params do
        requires :id, type: Integer, desc: "Offer id."
      end
      get ':id/outstanding' do
        data = {
          id: params[:id],
          offers: [
            {
              id: 1,
              company: {
                contact_person: {
                  name: "John Doe",
                  email: "email1",
                  phone: "0401234567"
                },
                name: "Junction Ltd.",
                price: 31231,
                annual_savings: 4321,
                annual_emission_savings: 10101,
                estimated_payback_time: 3.5,
              }
            },
            {
              id: 2,
              company: {
                contact_person: {
                  name: "Jane Smith",
                  email: "email2",
                  phone: "0412345678"
                },
                name: "Green Energy Solutions",
                price: 27500,
                annual_savings: 5500,
                annual_emission_savings: 8000,
                estimated_payback_time: 5.0
              }
            },
            {
              id: 3,
              company: {
                contact_person: {
                  name: "Michael Johnson",
                  email: "email3",
                  phone: "0423456789"
                },
                name: "SolarTech Inc.",
                price: 40000,
                annual_savings: 6000,
                annual_emission_savings: 9000,
                estimated_payback_time: 6.7
              }
            },
            {
              id: 4,
              company: {
                contact_person: {
                  name: "Emily Davis",
                  email: "email4",
                  phone: "0434567890"
                },
                name: "EcoPower Solutions",
                price: 35000,
                annual_savings: 7000,
                annual_emission_savings: 7500,
                estimated_payback_time: 5.0
              }
            },
            {
              id: 5,
              company: {
                contact_person: {
                  name: "David Wilson",
                  email: "email5",
                  phone: "0445678901"
                },
                name: "Renewable Energy Co.",
                price: 28000,
                annual_savings: 6000,
                annual_emission_savings: 8500,
                estimated_payback_time: 4.7
              }
            }
          ]
        }

        { data: data }
      end
    end
  end
end
