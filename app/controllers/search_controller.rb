class SearchController < ApplicationController
  def resultsproducto
    @productos = Product.buscador(params[:termino])
  end
  def resultscliente
    @clientes = Client.buscador(params[:termino])
  end
  def resultsproveedor
    @proveedores = Supplier.buscador(params[:termino])
  end
  #con los gets prawn funciona bien, con los POST no
  def resultsventasmes
    date = Date.today
    start_date = date.at_beginning_of_month
    end_date = date.at_end_of_month
    @ventas= Sale.where(:created_at => start_date..end_date)
  end
  def resultsventassemana
    date = Date.today
    start_date = date.at_beginning_of_week
    end_date = date.at_end_of_week
    @ventas2= Sale.where(:created_at => start_date..end_date)
  end
    
end
