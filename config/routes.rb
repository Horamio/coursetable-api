Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/' => 'ping#ping'
  get 'ping' => 'ping#ping'

  resources :colleges
  resources :faculties
  resources :specialities
  resources :courses
  resources :sections
end
