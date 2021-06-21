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
  #Rutas para las ubicaciones
  resources :locations
  #Rutas para las unidades
  resources :units
  #Rutas para los productos
  resources :products
  #Rutas para los clientes
  resources :clients
  #Rutas de los proveedores
  resources :suppliers
  #Rutas para ventas
  resources :sales do
    resources :sale_details
    collection do
      match 'search' => 'sales#search', via: [:get, :post], as: :search
    end
  end
  #Rutas para compras
  resources :purchases do
    resources :purchase_details
    collection do
      match 'search' => 'purchases#search', via: [:get, :post], as: :search
    end
  end
  
  #Rutas para empleados
  resources :employees
  #Rutas para las nominas
  resources :paychecks do
    collection do
      match 'search' => 'paychecks#search', via: [:get, :post], as: :search
    end
  end

  #Rutas para los tipo de pagos
  resources :type_payments
  #Rutas para los cargos
  resources :positions
  
  #Ruta para el buscador de productos en /app/javascript
  get 'buscador_productos/:termino', to: 'products#buscador'
  #Ruta para el buscador de productos en /app/javascript
  get 'buscador_productoscompra/:termino', to: 'products#buscadorcompra'
  #Ruta para agreagar productos al detalle de venta
  post 'add_item_venta', to: 'sales#add_item'

  #Ruta para buscar empleados
  get 'buscador_empleados/:termino', to: 'employees#buscador'
  #Ruta para agregar empleados a la nomina
  post 'add_empleado_nomina', to: 'paychecks#add_empleado'
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
  #Ruta para el buscador de productos
  post '/buscar_productos', to: 'search#resultsproducto'
  #Ruta para el buscador de clientes
  post '/buscar_clientes', to: 'search#resultscliente'
  #Ruta para el buscador de proveedores
  post '/buscar_proveedores', to: 'search#resultsproveedor'
  #ruta de ventas del mes
  get '/ventas_del_mes', to: 'search#resultsventasmes'
  #ruta de ventas de la semana
  get '/ventas_de_semana', to: 'search#resultsventassemana'
  
  # en caso de que la ruta no exista, redirecciona a root (poner siempre de ultimo)
  get '*path' => redirect('/')
  ###############################
end
