Rails.application.routes.draw do
  devise_for :users
  get "cats/index"
  get "cats/show"
  root 'cats#index'
  post 'cats/search', to: 'cats#search', as: 'search_cats'
  get 'cats/:id', to: 'cats#show', as: 'cat'
end
