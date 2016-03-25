class ArticlesController < ApplicationController

  before_action :set_article, only: [:show, :edit, :update, :destroy]
  
  def new
    @article = Article.new
  end
  
  def create
    # debugger => Adding in this line will stop the processing of the page and starts a debugger console where the rails server is running
    #render plain: params[:article].inspect => display what was sent on the screen
    @article = Article.new(article_params)
    @article.user = User.first # temporary until log in is implemented
    if @article.save
      flash[:success] = 'Article was successfully created'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:success] = 'Article was successfully updated'
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  
  def show
  end
  
  def edit
  end
  
  def index
    @article_list = Article.all
  end
  
  def destroy
    @article.destroy
    
    flash[:danger] = "Article was successfully deleted"
    redirect_to articles_path
  end
  
  private
  
  def article_params
    params.require(:article).permit(:title, :description)
  end
  
  def set_article
    @article = Article.find(params[:id])
  end
  
end
