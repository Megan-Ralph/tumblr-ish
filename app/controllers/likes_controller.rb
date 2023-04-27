class LikesController < ApplicationController
  def create
    @likeable = find_likeable
    @like = @likeable.likes.build(like_params)
    @like.user = current_user

    if @like.save
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end
  
  private

  def find_likeable
    if params[:like][:likeable_type] == "Event"
      Event.find(params[:like][:likeable_id])
    elsif params[:like][:likeable_type] == "Article"
      Article.find(params[:like][:likeable_id])
    elsif params[:like][:likeable_type] == "Comment"
      Comment.find(params[:like][:likeable_id])
    end
  end

  def like_params
    params.require(:like).permit(:likeable_type, :likeable_id)
  end
end
