class LocationsController < ApplicationController
  before_action :set_location, only: [:edit, :update, :destroy]
  
  def index
    @q = Location.ransack(params[:q])
    @lugares = @q.result
  end

  def new
    @lugar = Location.new
  end

  def edit
  end

  def create
    @lugar = Location.new(location_params)

    respond_to do |format|
      if @lugar.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @lugar.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @lugar.update(location_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @lugar.errors.full_messages, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
    
  end

  def destroy
    respond_to do |format|
      if @lugar.destroy
        format.json { head :no_content }
        format.js
      else
        flash[:error] = "No se ha podido borrar la ubicacion"
        format.html { redirect_to locations_path }
      end
    end
      
  end

  private
  def set_location
    @lugar = Location.find(params[:id])
  end

  def location_params
    params.require(:location).permit(:nombre_lugar)
  end
  
end
