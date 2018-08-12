Rails.application.routes.draw do
  resources :posts do
    collection do
       get :draft
     end
   end

  devise_for :users

  root 'posts#index'

end
