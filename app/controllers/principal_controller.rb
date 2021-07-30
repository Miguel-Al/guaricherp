class PrincipalController < ApplicationController
  def index
    @nombre =  current_user.username
    @cantclien = Client.all.count
    @cantprove = Supplier.all.count
    @monto = Sale.all.sum(:total_venta)
    @numventas = Sale.all.count
    @numcompras = Purchase.all.count
    @cantempleados = Employee.all.count
    @cantproductos = Product.all.count
  end
end

