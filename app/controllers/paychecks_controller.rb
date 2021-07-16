class PaychecksController < ApplicationController
  before_action :set_paycheck, only: [:edit, :destroy, :show, :add_empleado, :update]
  before_action :set_paycheck_type, only: [:edit, :destroy, :update, :show, :index, :search]
  before_action :set_type_payment, only: [:edit, :destroy, :update, :show]
  before_action :authenticate_allowed, only: [:index, :edit]

  def index
    @search = Paycheck.search(params[:q])
    @nominas = @search.result
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        pdf = ReporteNominaPdf.new(@nominas)
          send_data pdf.render, filename: "registro_de_nominas_#{DateTime.now.to_s(:number)}.pdf", type: "application/pdf", disposition: "inline"
      end
    end
  end

  def search
    index
    render :index
  end

  def new
    @nomina = current_user.paychecks.create(salario_nomina: 0.0)
    redirect_to edit_paycheck_path(@nomina)
  end

  def show
    @empresa = Company.last
    respond_to do |format|
      format.html
      format.js
      format.pdf do
        pdf = FichaNominaPdf.new(@nomina, @empresa)
          send_data pdf.render, filename: "fichadenomina_#{@nomina.employee.nombre_apellido}_#{@nomina.inicio_nomina}_#{@nomina.fin_nomina}.pdf", type: "application/pdf", disposition: "inline"
        end
          end
  end

  def edit
    @nomina2 = @nomina
  end

  def update
    @nomina = Paycheck.find(params[:id])
    if @nomina.update(paycheck_params)
      redirect_to paychecks_path, :notice => "Se ha registrado la nomina exitosamente"
    else
      render :edit
    end
  end

  def destroy
    @nomina.destroy
    respond_to do |format|
      format.html { redirect_to paychecks_url, notice: "La nomina ha sido eliminada" }
      format.json { head :no_content }
    end
  end 

   def add_empleado
     empleado = Employee.find(params[:empleado_id])
     dias_nomina = params[:dias_nomina].nil? ? 1 : params[:dias_nomina].to_i
     salario_empleado = (empleado.salario_empleado / 30).round(2)
     salario_nomina = salario_empleado * dias_nomina.to_d
     salario_empleado_total = empleado.salario_empleado
    if empleado.present?
      @nomina.employee = empleado
      @nomina.salario_empleado = salario_empleado_total
      @nomina.dias_nomina = dias_nomina
      @nomina.salario_nomina = salario_nomina
      if @nomina.valid?
        result = { primer_nombre: @nomina.employee.try(:nombre_apellido), salario_nomina: @nomina.salario_nomina}
        respond_to do |format|
          if @nomina.save && empleado.save
            format.json { render json: result }
          else
            format.json { render json: @nomina.errors.full_messages, status: :unprocessable_entity }
          end
        end
      end
    else
      render json: { message: "El empleado no se podido encontrar"}, status: :not_found
    end
  end


   protected
   def authenticate_allowed
    return if current_user.role_id == 1 || current_user.role_id == 2 || current_user.role_id == 3
    redirect_to root_path
   end
  
   private

   def paycheck_params
     params.require(:paycheck).permit(:paycheck_type_id, :inicio_nomina, :fin_nomina, :dias_nomina, :salario_nomina, :salario_empleado, :adelanto_nomina, :type_payment_id, :alimento_cesta)
   end

   def set_paycheck
     @nomina = Paycheck.find(params[:id])
   end

   def set_paycheck_type
     @tiponomina = PaycheckType.all
   end

   def set_type_payment
     @tipopago = TypePayment.all
   end

end
