Rails.application.routes.draw do
  root to: 'cats#index'

  resources :cats
  post '/cats/new' => 'cats#create'

  resources :cat_rental_requests
  post '/cat_rental_requests/new' => 'cat_rental_requests#create'
  post '/cat_rental_requests/:id/approve' => 'cat_rental_requests#approve', as: :approve
  post '/cat_rental_requests/:id/deny' => 'cat_rental_requests#deny', as: :deny

end
