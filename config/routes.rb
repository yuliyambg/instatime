Rails.application.routes.draw do

  root 'events#index'
  get 'events/my_events', to:'events#my_events'
  resources :events


  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
