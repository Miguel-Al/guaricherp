class PaychecksController < ApplicationController
  before_action :set_paycheck, only: [:edit, :update, :destroy]
  before_action :set_paycheck_type, only: [:new, :edit, :create]
  before_action :set_employee, only: [:new, :edit, :create]

  def index
    @q = Paycheck.ransack(params[:q])
    @paychecks = @q.result
  end

  def new
    @paycheck = Paycheck.new
  end

  def show
  end

  def edit
  end

  def create
    @paycheck = current_user.paychecks.new(paycheck_params)

    respond_to do |format|
      if @paycheck.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @paycheck.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  def update
  end

  def destroy
    @paycheck.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.js
    end
  end

  private

  def paycheck_params
      params.require(:paycheck).permit(:user_id, :employee_id, :paycheck_type_id, :salario_nomina, :inicio_nomina, :fin_nomina)
    end

  def set_paycheck
    @paycheck = Paycheck.find(params[:id])
  end

  def set_paycheck_type
    @tiponomina = PaycheckType.all
  end

  def set_employee
    @empleados = Employee.all
  end

end
