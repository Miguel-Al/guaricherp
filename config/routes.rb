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
  resources :products
  #Rutas para los clientes
  resources :clients, except: [:show]
  #Rutas de los proveedores
  resources :suppliers, except: [:show]
  #Rutas para ventas
  resources :sales do
    resources :sale_details
  end
  #Rutas para compras
  resources :purchases do
    resources :purchase_details
  end
  #Ruta para el buscador de productos en /app/javascript
  get 'buscador_productos/:termino', to: 'products#buscador'
  #Ruta para el buscador de productos en /app/javascript
  get 'buscador_productoscompra/:termino', to: 'products#buscadorcompra'
  #Ruta para agreagar productos al detalle de venta
  post 'add_item_venta', to: 'sales#add_item'
  
  #Ruta para buscar clientes
  get 'buscador_clientes/:termino', to: 'clients#buscador'
  #Ruta para agregar clientes a la venta
  post 'add_cliente_venta', to: 'sales#add_cliente'
  #Ruta para agreagar productos al detalle de compra
  post 'add_item_compra', to: 'purchases#add_item'
  #Ruta para buscar proveedores
  get 'buscador_proveedores/:termino', to: 'suppliers#buscador'
  #Ruta para agregar proveedores a la compra
  post 'add_proveedor_compra', to: 'purchases#add_proveedor'
  #Ruta para el buscador
  post '/search', to: 'search#results'
  
  # en caso de que la ruta no exista, redirecciona a root (poner siempre de ultimo)
  get '*path' => redirect('/')
  ###############################
end
