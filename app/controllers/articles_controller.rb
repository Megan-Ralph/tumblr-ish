class ArticlesController < ApplicationController
  before_action :authorise_user, only: [:edit, :update]
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
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
  end

  def update
    if current_user.admin? && @article.user != current_user
      @article.edited_by_admin = true
      @article.edited_by = current_user.id
      @article.edited_at = DateTime.now
    end

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article.destroy

    redirect_to root_path, alert: "Deleted"
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def authorise_user
    @article = Article.find(params[:id])

    unless current_user.admin? || @article.user == current_user
      flash[:alert] = "You are not authorised to perform this action."
      redirect_to root_path
    end
  end

  def article_params
    params.require(:article).permit(:title, :body, :edited_by_admin, :edited_by, :edited_at, :user_id).merge(user: current_user)
  end
end
