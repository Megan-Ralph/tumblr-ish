class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = (@user.articles + @user.events).sort_by(&:created_at)

    @activities = @user.activity_feed
  end

  def index
    @users = User.all
  end
end
