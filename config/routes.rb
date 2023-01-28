Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', controllers: {
        registrations: 'api/v1/auth/registrations',
        sessions: 'api/v1/auth/sessions'
      }
      scope format: 'json' do # json形式のリクエストに対応
        resources :reviews
        resources :coffees do
          collection do
            get 'mdata'
          end
          collection do
            post 'search'
          end
          resources :favorites, only: %w(create destroy index)
        end
      end
    end
  end
end
