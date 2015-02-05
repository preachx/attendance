Rails.application.routes.draw do
  mount Upmin::Engine => '/admin'
  root to: 'visitors#index'
  devise_for :users
  resources :users
  get "invitee/:id/events/:event_id" => 'invitee#event_invitee_details'
  resources :invitee
  get "events/today/invitees" => 'events#search'
  get "events/all" => 'events#get_all'
  get "events/update_invitee_people_count" => 'events#update_invitee_people_count'
  get "events/advanced_search", to: "events#advanced_search", as: "event_search"
  resources :events
end
