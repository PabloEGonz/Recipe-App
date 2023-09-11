Rails.application.routes.draw do
  devise_for :users

  get '/user_account', to: 'users#index'
  resources :foods, only: [:index, :new, :create, :show, :destroy ]
  resources :inventories, only: [:index, :new, :create, :show, :destroy ]
  resources :recipes, only: [:index, :update, :new, :create, :show, :destroy ] do
  resources :recipe_foods, only: [:update, :new, :create, :destroy ]
  end

  get '/general_shoping_list', to: 'foods#general_shoping_list'
  get '/public_recipes', to: 'recipes#public_recipes'
  root "foods#index"
end
