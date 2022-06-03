# frozen_string_literal: true

module Api
  module Auth
    class SessionsController < Devise::SessionsController
      respond_to(:json)

      private

      def respond_with(resource, _opts = {})
        render(json: { message: 'Sign in OK.' }, status: :ok)
      end

      def respond_to_on_destroy
        return render(json: { message: 'Sign out OK.' }, status: :ok) if current_user

        log_out_failure
      end

      def log_out_failure
        render(json: { message: 'Sign out not OK.' }, status: :unauthorized)
      end
    end
  end
end
