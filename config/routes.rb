Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :invitee
  get "events/search" => 'events#search'
  get "events/all" => 'events#get_all'
  resources :events
end
