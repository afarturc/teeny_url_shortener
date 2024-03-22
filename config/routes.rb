Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  get '/:short_url', to: 'clicks#redirect', as: 'redirect'

  resources :links, only: %i[index show new create destroy] do
    get '/statistics/:action', controller: 'statistics', as: 'statistics'
  end

  # Defines the root path route ("/")
  root 'links#index'
end
