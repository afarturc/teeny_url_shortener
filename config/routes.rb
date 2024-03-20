Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  get '/:short_url', to: 'clicks#redirect', as: 'redirect'

  resources :links, only: %i[index show new create destroy] do
    get '/statistics/clicks_last_30_days', to: 'statistics#clicks_last_30_days', as: 'clicks_last_30_days'
    get '/statistics/clicks_most_popular_days_of_week', to: 'statistics#clicks_most_popular_days_of_week',
                                                        as: 'clicks_most_popular_days_of_week'
    get '/statistics/clicks_most_popular_hours', to: 'statistics#clicks_most_popular_hours',
                                                 as: 'clicks_most_popular_hours'
  end

  # Defines the root path route ("/")
  root 'links#index'
end
