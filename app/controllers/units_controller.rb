class UnitsController < ApplicationController
  before_action :set_unit, only: [:edit, :update, :destroy]
  
  def index
    @q = Unit.ransack(params[:q])
    @unidades = @q.result
  end

  def new
    @unidad = Unit.new
  end

  def edit
  end

  def create
    @unidad = Unit.new(unit_params)

    respond_to do |format|
      if @unidad.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @unidad.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @unidad.update(unit_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @unidad.errors.full_messages, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
    
  end

  def destroy
    respond_to do |format|
      if @unidad.destroy
        format.json { head :no_content }
        format.js
      else
        flash[:error] = "No se ha podido borrar la unidad"
        format.html { redirect_to units_path }
      end
    end
      
  end

  private
  def set_unit
    @unidad = Unit.find(params[:id])
  end

  def unit_params
    params.require(:unit).permit(:nombre_unidad, :simbolo_unidad)
  end
  
end
