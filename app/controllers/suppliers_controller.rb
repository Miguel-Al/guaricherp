class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:edit, :update, :destroy, :show]
  before_action :authenticate_allowed, only: [:index]
    
  def index
    @q = Supplier.ransack(params[:q])
    @proveedores = @q.result().page(params[:page]).per(1)
  end

  def new
    @proveedor = Supplier.new
    @proveedor.phonesuppliers.build
  end

  def edit
  end

  def show
  end

  def create
    @proveedor = Supplier.new(supplier_params)
    
    respond_to do |format|
      if @proveedor.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @proveedor.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @proveedor.update(supplier_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @proveedor.errors.full_messages, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
  end

  def destroy
    @proveedor.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.js
    end
  end

   def buscador
    @resultados = Supplier.buscador(params[:termino]).map do |proveedor|
      {
        id: proveedor.id,
        numero_rif: proveedor.rif_proveedor,
        nombre_proveedor: proveedor.nombre_proveedor
      }
    end

    respond_to do |format|
      format.json { render :json => @resultados }
    end

  end

   protected
   def authenticate_allowed
     return if current_user.role_id == 1 || current_user.role_id == 2
     redirect_to root_path
   end

   private

  def set_supplier
    @proveedor = Supplier.find(params[:id])
  end

  def supplier_params
    params.require(:supplier).permit(:rif_proveedor, :nombre_proveedor, :correo_proveedor, :direccion_proveedor, :descripcion_proveedor, phonesuppliers_attributes: [:id, :_destroy, :numero_proveedor])
  end  
end
