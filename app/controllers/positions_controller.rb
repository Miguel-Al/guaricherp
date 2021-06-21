class PositionsController < ApplicationController
  before_action :set_position, only: [:edit, :update, :destroy]
  
  def index
    @q = Position.ransack(params[:q])
    @cargos = @q.result
  end

  def new
    @cargo = Position.new
  end

  def edit
  end

  def create
    @cargo = Position.new(category_params)

    respond_to do |format|
      if @cargo.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @cargo.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @cargo.update(category_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @cargo.errors.full_messages, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
    
  end

  def destroy
    respond_to do |format|
      if @cargo.destroy
        format.json { head :no_content }
        format.js
      else
        flash[:error] = "No se ha podido borrar el cargo"
        format.html { redirect_to positions_path }
      end
    end
      
  end

  private
  def set_position
    @cargo = Position.find(params[:id])
  end

  def position_params
    params.require(:position).permit(:nombre_cargo)
  end
  
end
