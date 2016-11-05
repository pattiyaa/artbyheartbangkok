Rails.application.routes.draw do
  
  get 'home/index'
  root 'home#index'
  
  namespace :admin do
    resources :articles
  end
  namespace :admin do
    get 'dashboard/index'
    root 'dashboard#index'
  end

  namespace :admin do
    resources :users
  end
	mount Ckeditor::Engine => '/ckeditor'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
end

