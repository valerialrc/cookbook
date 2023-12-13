class CategoriesController < ApplicationController
  before_action :authenticate_user!, only: %i[create new index]
  before_action :authorize_user, only: %i[create new index]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
    #@recipes = Recipe.joins(:has_category).where('has_category.category[id]')
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

  def authorize_user
    return redirect_to root_path unless current_user.admin?
  end
end