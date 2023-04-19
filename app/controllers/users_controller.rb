class UsersController < ApplicationController
  def show
    @user = current_user
    @posts = (Article.all.where(user: current_user) + Event.all.where(user: current_user)).sort_by(&:created_at)
  end
end
