Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  resources :posts do
    collection do
       get :draft
       get :subscribe
     end

     member do
       post 'like'
       get 'comments'
     end

     resources :comments, only: [:create, :destroy, :edit, :update] do
       member do
         post 'like'
         get 'replies'
       end
     end

     resources :comments, only: [:show] do
       resources :replies, only: [:new, :create, :edit, :update] do
         member do
           post 'like'
         end
       end
     end

     resources :replies, only: [:destroy]
   end



  devise_for :users

  resources :users, only: [:index]

  root 'posts#index'

end
