class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :add_item, :destroy, :add_proveedor]
  before_action :set_type_payment, only: [:edit, :destroy, :update, :show]
  before_action :authenticate_allowed, only: [:index, :edit]

   def index
    @search = Purchase.search(params[:q])
    @compras = @search.result.where.not(total_compra: 0.0).where.not(supplier_id: nil)
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        pdf = ReporteCompraPdf.new(@compras)
        send_data pdf.render, filename: "registro_de_compras_#{DateTime.now.to_s(:number)}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
   end

  def search
    index
    render :index
  end

  def new
    @compra = current_user.purchases.create(total_compra: 0.0)
    redirect_to edit_purchase_path(@compra)
  end

  def show
    @empresa = Company.last
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        pdf = RegistroCompraPdf.new(@compra, @empresa)
        send_data pdf.render, filename: "registrodecompra_#{@compra.numero_compra}_#{DateTime.now.to_s(:number)}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def edit
    @productos_compra = @compra.purchase_details
  end

  def update
    @compra = Purchase.find(params[:id])
    if @compra.update(purchase_params)
      redirect_to purchases_path, :notice => "La compra ha sido registrada"
    else
      render :edit
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
    @compra.purchase_details.map do |detail|
      prod_comprado = Product.find(detail.product_id)
      prod_comprado.existencia_producto-= detail.cantidad
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
    precio_detalle_compra = params[:precio_detalle_compra].nil? ? 1 : params[:precio_detalle_compra].to_d
    importe_producto = precio_detalle_compra * cantidad
    @purchase_detail = @compra.purchase_details.build(product: producto, cantidad: cantidad, precio_detalle_compra: precio_detalle_compra)
    importe_antes_registro = @compra.total_compra
    importe_despues_registro = importe_antes_registro + importe_producto
    @compra.total_compra = importe_despues_registro.round(2)

    existencia_antes_compra = producto.existencia_producto

    #esto agarra los valores y los envia el js
    result = {
      producto_id: @purchase_detail.product_id,
      nombre_producto: @purchase_detail.product.try(:nombre_producto),
      cantidad: @purchase_detail.cantidad,
      precio_detalle_compra: @purchase_detail.precio_detalle_compra,
      importe_item: @purchase_detail.precio_detalle_compra * cantidad,
      importe_compra: importe_despues_registro.round(2)
    }
    
    producto.existencia_producto = producto.existencia_producto + cantidad
    producto.precio_producto = precio_detalle_compra

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
      render json: { message: "El proveedor no se puedo encontrar"}, status: :not_found
    end
  end

  protected
  def authenticate_allowed
    return if current_user.role_id == 1 || current_user.role_id == 2 || current_user.role_id == 5
    redirect_to root_path
  end

  private

  def purchase_params
    params.require(:purchase).permit(:type_payment_id, :numero_compra)
  end
  
  def set_purchase
    @compra = Purchase.find(params[:id])
  end

  def set_type_payment
    @tipopago = TypePayment.all
  end
  
end
