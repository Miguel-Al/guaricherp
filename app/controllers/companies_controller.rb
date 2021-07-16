class CompaniesController < ApplicationController
  before_action :set_company
  before_action :authenticate_allowed, only: [:index]

  def index
    @empresa= Company.last
  end

  def new
    @empresa = Company.new
  end

  def edit
  end

  def create
    @empresa = Company.new(company_params)

    respond_to do |format|
      if @empresa.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @empresa.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @empresa.update(company_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @empresa.errors.full_messages, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
  end

  protected
  def authenticate_allowed
    return if current_user.role_id == 1 || current_user.role_id == 2
    redirect_to root_path
  end
  
  private

  def set_company
    @empresa = Company.last
  end

  def company_params
    params.require(:company).permit(:rif_empresa, :nombre_empresa, :direccion_empresa, :telefono_empresa, :numero_control)
  end

end
