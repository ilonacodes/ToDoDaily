Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'dashboard#dashboard', as: 'dashboard'

  post '/tasks', to: 'tasks#create'
  post '/tasks/:id/complete', to: 'tasks#complete', as: 'complete_task'

  get '/status', to: 'status#status'

  get '/all_days', to: 'dashboard#all_days', as: 'all_days'

  get '/all_days/:day', to: 'dashboard#single_day', as: 'single_day'
end
