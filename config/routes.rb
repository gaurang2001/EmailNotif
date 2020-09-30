Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "users#index"
  resources :users, only: [:index, :update] do
    member do
      get 'my_account', action: 'edit', as: 'my_account'
    end
    collection do
      get 'admin'
      post 'send_mail'
    end
  end
end
