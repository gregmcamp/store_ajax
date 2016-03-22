Rails.application.routes.draw do

  root 'products#index'

  resources :products

  # get 'products/edit'


  # get 'products/show'

  # get 'products/new'

end
