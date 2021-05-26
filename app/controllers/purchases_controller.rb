class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :add_item, :destroy, :add_proveedor]

  def index
    @compras = Purchase.all
  end


  def new
    @compra = current_user.purchases.create
    redirect_to edit_purchase_path(@compra)
  end

  def show
  end

  def edit
    @productos_compra = @compra.purchase_details
  end

  def destroy
    ActiveRecord::Base.transaction do
    @compra.purchase_details.map do |detail|
      prod_comprado = Product.find(detail.product_id)
      prod_comprado.existencia_producto+= detail.cantidad
      ActiveRecord::Rollback unless prod_comprado.save 
    end
    ActiveRecord::Rollback unless @compra.destroy
    end
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: "la compra ha sido eliminada"}
      format.json { head :no_contents }
    end
  end


  #ver como asignarle el valor del producto a antes de esto y incluirle que se vea la fecha en las ventas
  def add_item
    producto = Product.find(params[:producto_id])
    cantidad = params[:cantidad].nil? ? 1 : params[:cantidad].to_i
    @purchase_detail = @compra.purchase_details.build(product: producto, cantidad: cantidad)

    existencia_antes_compra = producto.existencia_producto

    #esto agarra los valores y los envia el js
    result = {
      producto_id: @purchase_detail.product_id,
      nombre_producto: @purchase_detail.product.try(:nombre_producto),
      cantidad: @purchase_detail.cantidad,
    }

    producto.existencia_producto = producto.existencia_producto + cantidad

    respond_to do |format|
      if @compra.save && producto.save
        format.json { render json: result }
      else
        format.json { render json: @compra.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end


  def add_proveedor
    proveedor = Supplier.find(params[:proveedor_id])
    if proveedor.present?
      @compra.supplier = proveedor
      if @compra.valid?
        result = { nombre_proveedor: @compra.supplier.try(:nombre_proveedor)}
        respond_to do |format|
          if @compra.save && proveedor.save
            format.json { render json: result }
          else
            format.json { render json: @compra.errors.full_messages, status: :unprocessable_entity }
          end
        end
      end
    else
      render json: { message: "El proveedor no se puedo encontrar"}, stauts: :not_found
    end
  end




  private

  def set_purchase
    @compra = Purchase.find(params[:id])
  end

end
