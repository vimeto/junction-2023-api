module Junction::Base
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid do |error|
      error! error.to_json, 422
    end

    helpers do
      def current_user
        @current_user ||= get_current_user
      end

      def authenticate_user!
        return if current_user

        error!({error: "Access denied"}, 401)
      end

      def authenticate_user
        nil if current_user
      end

      def get_current_user
        User.find_by("username", "admin") || User.create(username: "admin")
      end
    end
  end
end
