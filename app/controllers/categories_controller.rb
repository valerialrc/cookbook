class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      flash[:notice] = t('.success')
      redirect_to categories_path
    else
      @category = Category.new
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end