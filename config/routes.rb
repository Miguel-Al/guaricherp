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
  #Rutas para ventas
  resources :sales
  #Ruta para el buscador de productos en /app/javascript
  get 'buscador_productos/:termino', to: 'products#buscador'
  #Ruta para agreagar productos al detalle de venta
  post 'add_item_venta', to: 'sales#add_item'
  #Ruta para buscar clientes
  get 'buscador_clientes/:termino', to: 'clients#buscador'
  #Ruta para agregar clientes a la venta
  post 'add_cliente_venta', to: 'sales#add_cliente'

  
  # en caso de que la ruta no exista, redirecciona a root (poner siempre de ultimo)
  get '*path' => redirect('/')
  ###############################
end
