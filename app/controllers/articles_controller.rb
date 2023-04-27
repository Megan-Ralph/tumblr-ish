class ArticlesController < ApplicationController
  def show
    @article = Article.find(params[:id])
    @commentable = @article
    @comment = @commentable.comments.build
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path, alert: "Deleted"
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :user_id).merge(user: current_user)
  end
end
