Rails.application.routes.draw do
  #Necesario para acceder a rails admin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  #####################################

  #Necesario para gema devise
  devise_for :users
  ###########################

  #Ruta root
  root 'principal#index'
  #####################

  #Rutas para las categorias
  resources :categories
  #Rutas para los productos
  resources :products, except: [:show]
  #Rutas para los clientes
  resources :clients, except: [:show]
  #Rutas de los proveedores
  resources :suppliers, except: [:show]
  
  # en caso de que la ruta no exista, redirecciona a root
  get '*path' => redirect('/')
  ###############################
end
