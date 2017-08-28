Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#dashboard'

  post '/tasks', to: 'tasks#create'
  get '/status', to: 'status#status'
end
