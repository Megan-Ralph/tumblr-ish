class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = (Article.all.where(user: @user) + Event.all.where(user: @user)).sort_by(&:created_at)
  end

  def index
    @users = User.all
  end
end
