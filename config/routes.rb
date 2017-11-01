Rails.application.routes.draw do
  root 'home#index'
  get '/index', to: 'home#index'
  get '/games-reports', to: 'home#index'
  post '/games-reports', to: 'home#games_reports'
end
