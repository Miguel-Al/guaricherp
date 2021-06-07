class ProductsController < ApplicationController
  before_action :set_product, only: [:edit, :update, :destroy, :show]
  before_action :set_categories, only: [:new, :edit, :create]
  before_action :set_units, only: [:new, :edit, :create]
  before_action :set_locations, only: [:new, :edit, :create]
  
  def index
    @productos = Product.all
  end


  def new
    @product = Product.new
  end

  def show
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @product.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @product.errors.full_messages, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
  end

    def destroy
    @product.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.js
    end
    end

    def buscador
      @resultados = Product.buscador(params[:termino]).map do |producto|
        {
          id: producto.id,
          nombre_producto: producto.nombre_producto,
          precio_producto: producto.precio_producto,
          existencia_producto: producto.existencia_producto
        }
      end

      respond_to do |format|
        format.json { render :json => @resultados }
      end
      
    end

    def buscadorcompra
      @resultados = Product.buscador(params[:termino]).map do |producto|
        {
          id: producto.id,
          nombre_producto: producto.nombre_producto,
          existencia_producto: producto.existencia_producto
        }
      end

      respond_to do |format|
        format.json { render :json => @resultados }
      end
      
    end

    private
    def product_params
      params.require(:product).permit(:codigo_producto, :nombre_producto, :existencia_producto, :descripcion_producto, :precio_producto, :min_producto, :max_producto, :condicion_producto, :category_id, :unit_id, :location_id)
    end

    def set_product
      @product = Product.find(params[:id])
    end
    
    def set_categories
      @categorias = Category.all
    end
    
    def set_units
      @unidades = Unit.all
    end

    def set_locations
      @locaciones = Location.all
    end

    
end
