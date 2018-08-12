Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  resources :posts do
    collection do
       get :draft
     end
   end

  devise_for :users

  root 'posts#index'

end
