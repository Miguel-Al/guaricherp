class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :add_item, :destroy, :add_cliente]
  before_action :set_type_payment, only: [:edit, :destroy, :update, :show]
  before_action :authenticate_allowed, only: [:index, :edit]

   def index
    @search = Sale.search(params[:q])
    @ventas = @search.result
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        pdf = ReporteVentaPdf.new(@ventas)
        send_data pdf.render, filename: "registro_de_ventas_#{DateTime.now.to_s(:number)}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
   end

  def search
    index
    render :index
  end

  def new
    @venta = current_user.sales.create(total_venta: 0.0, numero_venta: "#{Sale.all.count+1}")
    redirect_to edit_sale_path(@venta)
  end

  def show
    @empresa = Company.last
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        pdf = FacturaVentaPdf.new(@venta, @empresa)
        send_data pdf.render, filename: "facturadeventa_#{@venta.numero_venta}_#{DateTime.now.to_s(:number)}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def edit
    @productos_venta = @venta.sale_details
  end

  def update
    @venta = Sale.find(params[:id])
    if @venta.update(sale_params)
      redirect_to sales_path, :notice => "La venta ha sido realizada"
    else
      render :edit
    end
  end
  
  def destroy
    ActiveRecord::Base.transaction do
    @venta.sale_details.map do |detail|
      prod_vendido = Product.find(detail.product_id)
      prod_vendido.existencia_producto+= detail.cantidad
      ActiveRecord::Rollback unless prod_vendido.save 
    end
    ActiveRecord::Rollback unless @venta.destroy
    end
    respond_to do |format|
      format.html { redirect_to sales_url, notice: "La venta ha sido eliminada" }
      format.json { head :no_content }
    end
  end


  #ver si se puedo meter el precio del produto en la variable precio detalle antes del build
  #revisar como el proceso de como las rutas llegan a esta, para hacer la notacion de arriba
  # creo que si pongo algo como cantidad pero agarrando el precio del proudcto y enviandolo funcionaria creo
  def add_item
    producto = Product.find(params[:producto_id])
    precio_producto = producto.precio_producto.to_i
    cantidad = params[:cantidad].nil? ? 1 : params[:cantidad].to_i
    importe_producto = producto.precio_producto * cantidad
    @sale_detail = @venta.sale_details.build(product: producto, cantidad: cantidad, precio_detalle_venta: precio_producto)
    importe_antes_registro = @venta.total_venta
    importe_despues_registro = importe_antes_registro + importe_producto
    @venta.total_venta = importe_despues_registro.round(2)

    existencia_antes_venta = producto.existencia_producto

    result = {
      product_id: @sale_detail.product_id,
      precio_producto: @sale_detail.precio_detalle_venta,
      nombre_producto: @sale_detail.product.try(:nombre_producto),
      cantidad: @sale_detail.cantidad,
      importe_item: producto.precio_producto * cantidad,
      importe_venta: importe_despues_registro.round(2)
    }

    producto.existencia_producto = producto.existencia_producto - cantidad

    respond_to do |format|
      if @venta.save && producto.save
        format.json { render json: result }
      else
        format.json { render json: @venta.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  
  def add_cliente
    cliente = Client.find(params[:cliente_id])
    if cliente.present?
      @venta.client = cliente
      if @venta.valid?
        result = { nombre_cliente: @venta.client.try(:nombre_cliente)}
        respond_to do |format|
          if @venta.save && cliente.save
            format.json { render json: result }
          else
            format.json { render json: @venta.errors.full_messages, status: :unprocessable_entity }
          end
        end
      end
    else
      render json: { message: "El cliente no se puedo encontrar"}, status: :not_found
    end
  end

  protected
  def authenticate_allowed
    return if current_user.role_id == 1 || current_user.role_id == 2 || current_user.role_id == 4
    redirect_to root_path
  end
  
  private

  def sale_params
    params.require(:sale).permit(:type_payment_id)
  end
  
  def set_sale
    @venta = Sale.find(params[:id])
  end

  def set_type_payment
    @tipopago = TypePayment.all
  end
  
end
