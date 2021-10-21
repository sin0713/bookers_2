Rails.application.routes.draw do
  root to: 'homes#top'
  get 'home/about' => 'homes#about'
  get '/search' => 'searchs#search'
  devise_for :users

  resources :books, only: [:index, :create, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]

    resources :book_comments, only: [:create, :destroy]

  end

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end


