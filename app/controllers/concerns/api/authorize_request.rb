module Api
  module AuthorizeRequest
    extend(ActiveSupport::Concern)

    PERMITTED_ROLES = nil

    included do
      before_action(:authenticate_user!)
    end

    def authorize!
      # I'm using `ActiveRecord::RecordInvalid` because it responds with a 422,
      # but the best way should be to create a custom Error
      if self.class::PERMITTED_ROLES.blank? || (self.class::PERMITTED_ROLES - User::ROLES).size.positive?
        raise(Errors::Api::PermissionsError, 'Error defining the PERMITTED_ROLES')
      end

      return true if self.class::PERMITTED_ROLES.include?(current_user.role)

      raise(Errors::Api::UnauthorizedError, 'The user does not have the permissions to access this resource')
    end
  end
end
