Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :posts do
    collection do
       get :draft
       get :subscribe
     end
     resources :comments, only: [:create, :destroy, :edit, :update]
   end

  devise_for :users

  root 'posts#index'

end
