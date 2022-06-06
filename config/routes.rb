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
    namespace(:admin) do
      post('/pokemons', to: 'pokemons#create')
    end
    get('/pokemons', to: 'pokemons#index')
    get('/pokemons/:pokemon_id', :pokemon_id => /\d+/, to: 'pokemons#show')
    get('/pokemons/:pokemon_name', :pokemon_name => /[A-Za-z0-9]+/ , to: 'pokemons#show')
    post('/pokemons/:pokemon_id/capture', :pokemon_id => /\d+/, to: 'pokemons#capture')
    post('/pokemons/:pokemon_name/capture', :pokemon_name => /[A-Za-z0-9]+/ , to: 'pokemons#capture')
    get('/captures', to: 'captures#index')
  end
end
