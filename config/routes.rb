Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "tweets#index"
  resources :likes, only: [:show, :index]
  resources :users, only: [:show, :edit, :update]
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  resources :tweets do
    resources :comments, only: [:create, :destroy, :edit]
  end
  resources :relationships, only: [:create, :destroy, :index]
end
