Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'games#index'

  get 'reviews/descending_order' => 'reviews#descending_order'

  
  
  resources :reviews

  resources :games do 
    resources :reviews 
  end

end
