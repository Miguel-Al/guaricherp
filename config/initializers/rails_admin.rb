require "nested_form/engine"
require "nested_form/builder_mixin"

RailsAdmin.config do |config|
  config.main_app_name = ["GuarichERP", "Admin"]

  #Auntenficia si hay un usuario logeado
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
  #########################################

  #Esconder el modelo del navegador a la izquierda
  config.model 'Role' do
    visible false
  end
  config.model 'SaleDetail' do
    visible false
  end
  config.model 'PurchaseDetail' do
    visible false
  end
  config.model 'Phoneployee' do
    visible false
  end
  config.model 'Phoneclient' do
    visible false
  end
  config.model 'Phonesupplier' do
    visible false
  end

  # mostrar campos de creacion y edicion de rails admin

  config.model 'User' do
    label 'Usuarios'
    list do
      field :id do
        filterable false
      end
      field :username do
        filterable false
      end
      field :email do
        filterable false
      end
      field :role do
        filterable false
        pretty_value do
          bindings[:object].role.nombre_rol
        end
      end
    end
    show do
      field :username
      field :email
      field :password
      field :role do
        pretty_value do
          bindings[:object].role.nombre_rol
        end
      end
    end
    edit do
      field :username
      field :email
      field :password
      field :role_id, :enum do
        enum do
          Role.all.collect {|p| [p.nombre_rol, p.id]}
        end
      end
    end
  end

  config.model 'Unit' do
    label 'Unidades'
    list do
      field :id do
        filterable false
      end
      field :nombre_unidad do
        filterable false
      end
      field :simbolo_unidad do
        filterable false
      end
    end
    show do
      field :nombre_unidad
      field :simbolo_unidad
    end
    edit do
      field :nombre_unidad
      field :simbolo_unidad
    end
  end

  config.model 'Category' do
    label 'Categorias'
    list do
      field :id do
        filterable false
      end
      field :nombre_categoria do
        filterable false
      end
      field :descripcion_categoria do
        filterable false
      end
    end
    show do
      field :nombre_categoria
      field :descripcion_categoria
    end
    edit do
      field :nombre_categoria
      field :descripcion_categoria
    end
  end

  config.model 'Client' do
    label 'Clientes'
    list do
      field :id do
        filterable false
      end
      field :rif_cliente do
        filterable false
      end
      field :nombre_cliente do
        filterable false
      end
      field :type_client do
        filterable false
        pretty_value do
          bindings[:object].type_client.nombre_tipo_cliente
        end
      end
      field :correo_cliente do
        filterable false
      end
    end
    show do
      field :rif_cliente
      field :nombre_cliente
      field :type_client do
        pretty_value do
          bindings[:object].type_client.nombre_tipo_cliente
        end
      end
      field :direccion_cliente
      field :phoneclients do
        pretty_value do
          bindings[:object].phoneclients.map do |tel|
            tel.numero_cliente
          end
        end
      end
      field :correo_cliente
      field :descripcion_cliente
    end
    edit do
      field :rif_cliente
      field :nombre_cliente
      field :type_client_id, :enum do
        enum do
          TypeClient.all.collect {|p| [p.nombre_tipo_cliente, p.id]}
        end
      end
      field :direccion_cliente
      field :phoneclients
      field :correo_cliente
      field :descripcion_cliente
    end
  end

  config.model 'Employee' do
    label 'Empleados'
    list do
      field :id do
        filterable false
      end
      field :numero_cedula do
        filterable false
      end
      field :primer_nombre do
        filterable false
      end
      field :primer_apellido do
        filterable false
      end
      field :position do
        filterable false
        pretty_value do
          bindings[:object].position.nombre_cargo
        end
      end
      field :salario_empleado do
        filterable false
      end
    end
    show do
      field :numero_cedula
      field :primer_nombre
      field :segundo_nombre
      field :primer_apellido
      field :segundo_apellido
      field :direccion_empleado
      field :phoneployees do
        pretty_value do
          bindings[:object].phoneployees.map do |tel|
            tel.numero_empleado
          end
        end
      end
      field :fecha_ingreso
      field :position do
        pretty_value do
          bindings[:object].position.nombre_cargo
        end
      end
      field :salario_empleado
      field :correo_empleado
    end
    edit do
      field :numero_cedula
      field :primer_nombre
      field :segundo_nombre
      field :primer_apellido
      field :segundo_apellido
      field :direccion_empleado
      field :phoneployees
      field :fecha_ingreso
      field :position_id, :enum do
        enum do
          Position.all.collect {|p| [p.nombre_cargo, p.id]}
        end
      end
      field :salario_empleado
      field :correo_empleado
    end
  end

  config.model 'Location' do
    label 'Ubicaciones'
    list do
      field :id do
        filterable false
      end
      field :nombre_lugar do
        filterable false
      end
    end
    show do
      field :nombre_lugar
    end
    edit do
      field :nombre_lugar
    end
  end

  config.model 'Position' do
    label 'Cargos'
    list do
      field :id do
        filterable false
      end
      field :nombre_cargo do
        filterable false
      end
    end
    show do
      field :nombre_cargo
    end
    edit do
      field :nombre_cargo
    end
  end

  config.model 'PaycheckType' do
    label 'Tipo de nomina'
    list do
      field :id do
        filterable false
      end
      field :tipo_nomina_nombre do
        filterable false
      end
    end
    show do
      field :tipo_nomina_nombre
    end
    edit do
      field :tipo_nomina_nombre
    end
  end

  config.model 'Supplier' do
    label 'Proveedores'
    list do
      field :id do
        filterable false
      end
      field :rif_proveedor do
        filterable false
      end
      field :nombre_proveedor do
        filterable false
      end
      field :correo_proveedor do
        filterable false
      end
    end
    show do
      field :rif_proveedor
      field :nombre_proveedor
      field :direccion_proveedor
      field :phonesuppliers do
        pretty_value do
          bindings[:object].phonesuppliers.map do |tel|
            tel.numero_proveedor
          end
        end
      end
      field :correo_proveedor
      field :descripcion_proveedor
    end
    edit do
      field :rif_proveedor
      field :nombre_proveedor
      field :direccion_proveedor
      field :phonesuppliers
      field :correo_proveedor
      field :descripcion_proveedor
    end
  end

  config.model 'TypeClient' do
    label 'Tipo cliente'
    list do
      field :id do
        filterable false
      end
      field :nombre_tipo_cliente do
        filterable false
      end
    end
    show do
      field :nombre_tipo_cliente
    end
    edit do
      field :nombre_tipo_cliente
    end
  end

  config.model 'TypePayment' do
    label 'Forma de pago'
    list do
      field :id do
        filterable false
      end
      field :nombre_tipo_pago do
        filterable false
      end
    end
    show do
      field :nombre_tipo_pago
    end
    edit do
      field :nombre_tipo_pago
    end
  end

  config.model 'Product' do
    label 'Producto'
    list do
      field :id do
        filterable false
      end
      field :codigo_producto do
        filterable false
      end
      field :nombre_producto do
        filterable false
      end
      field :category do
        filterable false
        pretty_value do
          bindings[:object].category.nombre_categoria
        end
      end
      field :unit do
        filterable false
        pretty_value do
          bindings[:object].unit.nombre_unidad
        end
      end
      field :location do
        filterable false
        pretty_value do
          bindings[:object].location.nombre_lugar
        end
      end
      field :precio_producto do
        filterable false
      end
      field :existencia_producto do
        filterable false
      end
      field :min_producto do
        filterable false
      end
      field :descripcion_producto do
        filterable false
      end
    end
    show do
      field :codigo_producto
      field :nombre_producto
      field :category do
        pretty_value do
          bindings[:object].category.nombre_categoria
        end
      end
      field :unit do
        pretty_value do
          bindings[:object].unit.nombre_unidad
        end
      end
      field :location do
        pretty_value do
          bindings[:object].location.nombre_lugar
        end
      end
      field :precio_producto
      field :existencia_producto
      field :min_producto
      field :descripcion_producto
    end
    edit do
      field :codigo_producto
      field :nombre_producto
      field :category_id, :enum do
        enum do
          Category.all.collect {|p| [p.nombre_categoria, p.id]}
        end
      end
      field :unit_id, :enum do
        enum do
          Unit.all.collect {|p| [p.nombre_unidad, p.id]}
        end
      end
      field :location_id, :enum do
        enum do
          Location.all.collect {|p| [p.nombre_lugar, p.id]}
        end
      end
      field :precio_producto
      field :existencia_producto
      field :min_producto
      field :descripcion_producto
    end
  end

  config.model 'Sale' do
    label 'Venta'
    list do
      field :id do
        filterable false
      end
      field :numero_venta do
        filterable false
      end
      field :encargado do
        filterable false
        pretty_value do
          bindings[:object].user.username
        end
      end
      field :cliente do
        filterable false
        pretty_value do
          bindings[:object].try(:client).try(:nombre_cliente)
        end
      end
      field :fecha do
        filterable false
        pretty_value do
          bindings[:object].created_at
        end
      end
    end
    show do
      field :numero_venta
      field :user do
        pretty_value do
          bindings[:object].user.username
        end
      end
      field :client do
        pretty_value do
          bindings[:object].client.nombre_cliente
        end
      end
      field :type_payment do
        pretty_value do
          bindings[:object].type_payment.nombre_tipo_pago
        end
      end
    end
  end

  config.model 'Purchase' do
    label 'Compra'
    list do
      field :id do
        filterable false
      end
      field :numero_compra do
        filterable false
      end
      field :encargado do
        filterable false
        pretty_value do
          bindings[:object].user.username
        end
      end
      field :proveedor do
        filterable false
        pretty_value do
          bindings[:object].try(:supplier).try(:nombre_proveedor)
        end
      end
      field :fecha do
        filterable false
        pretty_value do
          bindings[:object].created_at
        end
      end
    end
    show do
      field :numero_compra
      field :user do
        pretty_value do
          bindings[:object].user.username
        end
      end
      field :supplier do
        pretty_value do
          bindings[:object].supplier.nombre_proveedor
        end
      end
      field :type_payment do
        pretty_value do
          bindings[:object].type_payment.nombre_tipo_pago
        end
      end
    end
  end
  
  config.model 'Paycheck' do
    label 'Nomina'
    list do
      field :id do
        filterable false
      end
      field :encargado do
        filterable false
        pretty_value do
          bindings[:object].user.username
        end
      end
      field :empleado do
        filterable false
        pretty_value do
          bindings[:object].try(:employee).try(:nombre_apellido)
        end
      end
      field :tipo_de_nomina do
        filterable false
        pretty_value do
          bindings[:object].try(:paycheck_type).try(:tipo_nomina_nombre)
        end
      end
      field :periodo do
        filterable false
        pretty_value do
          bindings[:object].periodo
        end
      end
    end
    show do
      field :user do
        pretty_value do
          bindings[:object].user.username
        end
      end
      field :employee do
        pretty_value do
          bindings[:object].employee.nombre_apellido
        end
      end
      field :paycheck_type do
        pretty_value do
          bindings[:object].paycheck_type.tipo_nomina_nombre
        end
      end
      field :type_payment do
        pretty_value do
          bindings[:object].type_payment.nombre_tipo_pago
        end
      end
      field :inicio_nomina
      field :fin_nomina
      field :salario_empleado
      field :dias_nomina
      field :salario_nomina
      field :alimento_cesta
      field :adelanto_nomina
    end
  end


  #Autoriza acceso si tiene rol admin (acomodar en un futuro)
  config.authorize_with do
    redirect_to main_app.root_path unless current_user.role_id==1
  end
  
##########################################

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  config.show_gravatar = false

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except ['Role', 'Sale', 'Paycheck', 'Purchase']
    end
    export
    bulk_delete
    show 
    edit do
      except ['Role', 'Sale', 'Paycheck', 'Purchase']
    end
    delete
    #show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
