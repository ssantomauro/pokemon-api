module ApiHelper

  def authenticated_headers(user:, headers: {})
    Devise::JWT::TestHelpers.auth_headers(headers, user)
  end

end