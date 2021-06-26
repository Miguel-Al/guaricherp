class EmployeesController < ApplicationController
  before_action :set_employee, only: [:edit, :update, :destroy, :show]
  before_action :set_position, only: [:new, :edit, :create, :update]

  def index
    @q = Employee.ransack(params[:q])
    @empleados = @q.result
  end

  def new
    @empleado = Employee.new
    @empleado.phoneployees.build
  end

  def edit
  end

  def create
    @empleado = Employee.new(employee_params)

    respond_to do |format|
      if @empleado.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @empleado.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  def show
  end
  
  def update
    respond_to do |format|
      if @empleado.update(employee_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @empleado.errors.full_messages, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
  end

  def destroy
    @empleado.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.js
    end
  end

  #antes aaqui en donde dice empleado.nombre_apellido, estaba empleado.primer_nombre
  def buscador
    @resultados = Employee.buscador(params[:termino]).map do |empleado|
      {
        id: empleado.id,
        primer_nombre: empleado.nombre_apellido,
        salario: empleado.salario_empleado
      }
    end

    respond_to do |format|
      format.json { render :json => @resultados }
    end

  end

  #cambiar esto
  private
  def employee_params
    params.require(:employee).permit(:numero_cedula, :primer_nombre, :segundo_nombre, :primer_apellido, :segundo_apellido, :fecha_ingreso, :direccion_empleado, :correo_empleado, :salario_empleado, :position_id, phoneployees_attributes: [:id, :_destroy, :numero_empleado])
  end

    def set_employee
      @empleado = Employee.find(params[:id])
    end

    def set_position
      @cargos = Position.all
    end
end
