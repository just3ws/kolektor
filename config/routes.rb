Rails.application.routes.draw do
  # get 'errors/not_found'
  # get 'errors/internal_server_error'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # Catch-all route for routing errors (404)

  match '*unmatched_route', to: 'errors#not_found', via: :all

end
