Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/directors', to: 'directors#index'
  get '/directors/new', to: 'directors#new'
  get '/directors/:id', to: 'directors#show'
  get '/films', to: 'films#index'
  get '/films/:id', to: 'films#show'
  get '/directors/:director_id/films', to: 'director_films#index'
  post '/directors', to:'directors#create'
end
