# app/api/my_app/my_resource.rb
module Junction
  class Welcome < Grape::API
    resource :welcome do
      desc 'Welcome page'
      get do
        { message: 'Welcome to Junction API' }
      end

      desc 'Tell current time'
      get :time do
        { time: Time.now }
      end
    end
  end
end
