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
          name: "Geothermal 2023",
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
            name: "Geothermal",
            product: "Mitsubishi 2023",
            price: 22150,
            due_date: "2026-11-25",
            annual_savings: 3800,
            annual_emission_savings: 1011,
            estimated_payback_time: 5.8,
          },
          messages: [
            {
              id: 1,
              user: "root@root.fi",
              message: "Dear representative of [receiving company],\n\nI am considering installing a geothermal system to my house at address: Junctionstreet 3, Helsinki. Currently we use district heating and the floor surface is 239 sqm. We prefer the project to stay below 30000. I am inquiring for a directing offer and the possible time frame of the installment. I wish that the offer would include both the machinery, materials and the installment work. What is the name of the device/system you recommend for us?\n\nSincerely,\nOn behalf of the customer, GYP-agent"
            },
            {
              id: 2,
              user: "joni.taikina@gmale.com",
              message: "Hello! Let me get back to you with an offer in a few days. -Joni"
            },
            {
              id: 3,
              user: "root@root.fi",
              message: "Ok! Thank you! -GYP-agent"
            },
            {
              id: 4,
              user: "joni.taikina@gmale.com",
              message: "Hello! I am able to provide our Mitsubishi 2023 model for 25000. How does that sound? -Joni"
            },
            {
              id: 5,
              user: "root@root.fi",
              message: "Hello! That seems to be a bit expensive comparing to the market price on that model. Can you do 21000? -GYP-agent"
            },
            {
              id: 6,
              user: "joni.taikina@gmale.com",
              message: "OK, I can do 22150. -Joni"
            },
            {
              id: 7,
              user: "root@root.fi",
              message: "Ok, thank you! I will get back to you in a few days. -GYP-agent"
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
              name: "123321",
              company: {
                contact_person: {
                  name: "John Doe",
                  email: "email1",
                  phone: "0401234567"
                },
                name: "Junction Ltd.",
                price: 22150,
                annual_savings: 3800,
                annual_emission_savings: 1000,
                estimated_payback_time: 5.8,
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
                annual_emission_savings: 800,
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
                annual_emission_savings: 900,
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
                price: 32000,
                annual_savings: 3100,
                annual_emission_savings: 300,
                estimated_payback_time: 10.3
              }
            }
          ]
        }

        { data: data }
      end
    end
  end
end
