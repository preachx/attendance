Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users
  resources :invitee
  get "events/today/invitees" => 'events#search'
  get "events/all" => 'events#get_all'
  put "events/update_invitee_people_count" => 'events#update_invitee_people_count'
  resources :events
end
