class ClientsController < ApplicationController
  before_action :set_client, only: [:edit, :update, :destroy]
  before_action :set_type_clients, only: [:new, :edit, :create]

  def index
    @clientes = Client.all
  end

  def new
    @client = Client.new
  end

  def edit
  end

  def create
    @client = Client.new(client_params)

    respond_to do |format|
      if @client.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @client.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @client.update(client_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @client.errors.full_messages, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
  end

  def destroy
    @client.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.js
    end
  end

  def buscador
    @resultados = Client.buscador(params[:termino]).map do |cliente|
      {
        id: cliente.id,
        nombre_cliente: cliente.nombre_cliente
      }
    end

    respond_to do |format|
      format.json { render :json => @resultados }
    end

  end

  private
    def client_params
      params.require(:client).permit(:rif_cliente, :nombre_cliente, :correo_cliente, :descripcion_cliente, :type_client_id)
    end

    def set_client
      @client = Client.find(params[:id])
    end

    def set_type_clients
      @tipoclientes = TypeClient.all
    end

end
