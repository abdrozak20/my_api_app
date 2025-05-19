Rails.application.routes.draw do
    post '/login', to: 'auth#login'
    post '/signup', to: 'auth#signup'
    post '/refresh', to: 'auth#refresh'
    get '/category', to: 'categories#get_all'
    resources :products
    
    get "up" => "rails/health#show", as: :rails_health_check
end
