class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy]
  before_action :authenticate_allowed, only: [:index]
  
  def index
    @q = Category.ransack(params[:q])
    @categorias = @q.result().page(params[:page]).per(1)
  end

  def new
    @categoria = Category.new
  end

  def edit
  end

  def create
    @categoria = Category.new(category_params)

    respond_to do |format|
      if @categoria.save
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @categoria.errors.full_messages, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @categoria.update(category_params)
        format.json { head :no_content }
        format.js
      else
        format.json { render json: @categoria.errors.full_messages, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @categoria.destroy
        format.json { head :no_content }
        format.js
      else
        flash[:error] = "No se ha podido borrar la categoria"
        format.html { redirect_to categories_path }
      end
    end
      
  end

  protected
  def authenticate_allowed
    return if current_user.role_id == 1 || current_user.role_id == 2
    redirect_to root_path
  end

  private
  def set_category
    @categoria = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:nombre_categoria, :descripcion_categoria)
  end
  
end
