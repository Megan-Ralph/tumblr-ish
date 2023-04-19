class PagesController < ApplicationController
  def home
    @posts = (Article.all + Event.all).sort_by(&:created_at)
  end
end
