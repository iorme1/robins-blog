Rails.application.routes.draw do
  get 'users/index'
  mount Ckeditor::Engine => '/ckeditor'

  resources :posts do
    collection do
       get :draft
       get :subscribe
     end
     resources :comments, only: [:create, :destroy, :edit, :update]
   end

  devise_for :users

  resources :users, only: [:index]

  root 'posts#index'

end
