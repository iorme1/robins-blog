Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'

  root 'posts#index'

  resources :posts do
    collection do
       get :draft
       get :subscribe
     end

     member do
       post 'like'
     end

     resources :comments, only: [:create, :edit, :update, :destroy]
   end

  devise_for :users
  resources :users, only: [:index]

  resources :comments, only: [:show] do
    member do
      post 'like'
      get 'replies'
    end

    resources :replies do
      member do
        post 'like'
      end
    end
  end

end
