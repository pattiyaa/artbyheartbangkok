Rails.application.routes.draw do
  


  namespace :admin do
    resources :articles
    resources :users
     get 'dashboard/index'
    root 'dashboard#index'
  end
	mount Ckeditor::Engine => '/ckeditor'
  
  get 'home/index'
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end

