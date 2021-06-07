class SearchController < ApplicationController
  def results
    @productos = Product.buscador(params[:termino])
    @cliente = Client.buscador(params[:termino])
    @proveedor = Supplier.buscador(params[:termino])
  end
end
