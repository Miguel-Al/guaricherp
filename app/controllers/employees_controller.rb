class EmployeesController < ApplicationController
  before_action :set_employee, only: [:edit, :update, :destroy, :show]
  before_action :set_positions, only: [:new, :edit, :update, :create]
  before_action :authenticate_allowed, only: [:index]

  def index
    @q = Employee.ransack(params[:q])
    @empleados = @q.result
  end

  def new
    @employee = Employee.new
    @employee.phoneployees.build
  end

  def edit
  end

  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @empleado.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end
  
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @empleado.errors.full_messages, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @employee.destroy
        format.json { head :no_content }
        format.js
      else
        flash[:error] = "No se ha podido borrar el empleado"
        format.html { redirect_to employees_path }
      end
    end
  end

  #antes aaqui en donde dice empleado.nombre_apellido, estaba empleado.primer_nombre
  def buscador
    @resultados = Employee.buscador(params[:termino]).map do |empleado|
      {
        id: empleado.id,
        cedula_empleado: empleado.numero_cedula,
        primer_nombre: empleado.nombre_apellido,
        salario: empleado.salario_empleado
      }
    end

    respond_to do |format|
      format.json { render :json => @resultados }
    end

  end

  protected
  def authenticate_allowed
    return if current_user.role_id == 1 || current_user.role_id == 2 || current_user.role_id == 3
    redirect_to root_path
  end

  private
  def employee_params
    params.require(:employee).permit(:numero_cedula, :primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :fecha_ingreso, :direccion_empleado, :correo_empleado, :salario_empleado, :position_id, phoneployees_attributes: [:id, :_destroy, :numero_empleado])
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def set_positions
    @cargos = Position.all
  end
  
end
