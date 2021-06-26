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

  # mostrar campos de creacion y edicion de rails admin


  config.model 'User' do
    edit do
      field :username
      field :email
      field :password
      field :role
    end
  end

  config.model 'Unit' do
    edit do
      field :nombre_unidad
      field :simbolo_unidad
    end
  end

  config.model 'Category' do
    edit do
      field :nombre_categoria
      field :descripcion_categoria
    end
  end

  config.model 'Client' do
    edit do
      field :rif_cliente
      field :nombre_cliente
      field :direccion_cliente
      field :type_client
      field :phoneclients
      field :correo_cliente
      field :descripcion_cliente
    end
  end

  config.model 'Employee' do
    edit do
      field :numero_cedula
      field :primer_nombre
      field :segundo_nombre
      field :primer_apellido
      field :segundo_apellido
      field :direccion_empleado
      field :fecha_ingreso
      field :position
      field :salario_empleado
      field :correo_empleado
    end
  end

  config.model 'Location' do
    edit do
      field :nombre_lugar
    end
  end

  config.model 'Position' do
    edit do
      field :nombre_cargo
    end
  end

  config.model 'PaycheckType' do
    edit do
      field :tipo_nomina_nombre
    end
  end

  config.model 'Supplier' do
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
    edit do
      field :nombre_tipo_cliente
    end
  end

  config.model 'TypePayment' do
    edit do
      field :nombre_tipo_pago
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
  # config.show_gravatar = true

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
