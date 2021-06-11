class PaychecksController < ApplicationController
  before_action :set_paycheck, only: [:edit, :destroy, :show, :add_empleado, :update]
  before_action :set_paycheck_type, only: [:edit, :destroy, :update, :show]

  def index
    @nominas = Paycheck.all
  end

  def new
    @nomina = current_user.paychecks.create(salario_nomina: 0.0)
    redirect_to edit_paycheck_path(@nomina)
  end

  def show
  end

  def edit
    @nomina2 = @nomina
  end

  def update
    @nomina = Paycheck.find(params[:id])
    if @nomina.update(paycheck_params)
      redirect_to paychecks_path, :notice => "si"
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
     salario_nomina = empleado.salario_empleado
    if empleado.present?
      @nomina.employee = empleado
      @nomina.salario_nomina = salario_nomina
      if @nomina.valid?
        result = { primer_nombre: @nomina.employee.try(:primer_nombre), salario_nomina: @nomina.salario_nomina}
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

  
   private

   def paycheck_params
  params.require(:paycheck).permit(:paycheck_type_id, :inicio_nomina, :fin_nomina, :dias_nomina, :horas_extra, :adelanto_nomina)
end

  def set_paycheck
    @nomina = Paycheck.find(params[:id])
  end

  def set_paycheck_type
    @tiponomina = PaycheckType.all
  end

end
