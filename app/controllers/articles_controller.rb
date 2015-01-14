class ArticlesController < ApplicationController

	# before_filter :find_article, except: [:index, :new, :create]
	
  def index
  	@articles = Article.all
  	render :index
  end

  def new
  	@articles = Article.new
  	render :new
  end

  def create
  	new_article = params.require(:article).permit(:title, :author, :description)
  	article = Article.create(new_article)
  	redirect_to article_path(article.id)
  end

  # def show
  # 	id = params[:id]
  # 	@article = Article.find(id)
  # 	render :show
  # end

  def show
    @article = Article.find(params[:id])
    # calls the make_request method in Article model.
    @blogKeywords = @article.make_request
    render :show
  end

  def edit
  	@article = Article.find(params[:id])
  	render :edit
  end

  def update
  	article = Article.find(params[:id])
  	article_params = params.require(:article).permit(:title, :author, :description)
  	article.update(article_params)
  	redirect_to article_path(article)
  end

  def destroy
  	article = Article.find(params[:id])
  	article.destroy
  	redirect_to articles_path
  end


end
