class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = (@user.articles + @user.events).sort_by(&:created_at)

    @acitivity = (@user.articles + @user.events + @user.comments).sort_by(&:created_at).take(10)
  end

  def index
    @users = User.all
  end
end
