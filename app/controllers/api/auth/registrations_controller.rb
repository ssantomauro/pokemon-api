# frozen_string_literal: true

module Api
  module Auth
    class RegistrationsController < Devise::RegistrationsController
      respond_to(:json)

      private

      def respond_with(resource, _opts = {})
        return render(json: { message: 'Sign up OK.' }) if resource.persisted?

        register_failed
      end

      # The message is very generic. This is the concept of "paranoic" approach,
      # it means the message doesn't say anything that can give to the user info
      # like "the email already exists", "password missing", and so on.
      # However, this is just a basic implementation to
      # bring your attention to the authentication process.
      #
      # In a production environment the authentication needs a deeper discussion
      # to check the messages we want to display and the general config (field validations, etc.).
      def register_failed
        render(json: { message: 'There is something wrong with your request.' })
      end
    end
  end
end
