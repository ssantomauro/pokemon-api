Rails.application.routes.draw do
  devise_for(
    :users,
    path: 'api/auth',
    controllers: { sessions: 'api/auth/sessions' }
  )

  # APIs
  namespace(:api) do
    namespace(:auth) do
      devise_scope :user do
        # This route is because the default Devise uses 'POST /api/auth'
        post('/sign_up', to: 'registrations#create')
      end
    end
  end
end
