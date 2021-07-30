class TypePaymentsController < ApplicationController
  before_action :set_typepayment, only: [:edit, :update, :destroy]
  before_action :authenticate_allowed, only: [:index]
  
  def index
    @q = TypePayment.ransack(params[:q])
    @tipodepagos = @q.result().page(params[:page]).per(10)
  end

  def new
    @tipodepago = TypePayment.new
  end

  def edit
  end

  def create
    @tipodepago = TypePayment.new(typepayment_params)

    respond_to do |format|
      if @tipodepago.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @tipodepago.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @tipodepago.update(typepayment_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @tipodepago.errors.full_messages, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
    
  end

  def destroy
    respond_to do |format|
      if @tipodepago.destroy
        format.json { head :no_content }
        format.js
      else
        flash[:error] = "No se ha podido borrar el tipo de pago"
        format.html { redirect_to type_payments_path }
      end
    end
      
  end

  protected
  def authenticate_allowed
    return if current_user.role_id == 1 || current_user.role_id == 2
    redirect_to root_path
  end
   
  private
  def set_typepayment
    @tipodepago = TypePayment.find(params[:id])
  end

  def typepayment_params
    params.require(:type_payment).permit(:nombre_tipo_pago)
  end
  
end
