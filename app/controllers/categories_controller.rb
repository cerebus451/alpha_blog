class CategoriesController < ApplicationController
  
  before_action :require_admin, only: [:new, :create, :edit, :update]
  before_action :get_category, only: [:show, :edit, :update]
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @category = Category.new
  end
  
  def show
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category was created successfully"
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @category.update(category_params)
      flash[:success] = "Category successfully renamed"
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end
  
  private
  
  def get_category
    @category = Category.find(params[:id])
  end
  
  def category_params
    params.require(:category).permit(:name)
  end
  
  def require_admin
    if !logged_in? || !current_user.is_admin?
      flash[:danger] = "You must be an administrator to create/modify categories"
      redirect_to categories_path
    end
  end
  
end
