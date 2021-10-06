Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  get 'users/index'
  get 'books/index'
  get 'books/show'
  get 'books/edit'
  get 'homes/top'
  get 'homes/about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
