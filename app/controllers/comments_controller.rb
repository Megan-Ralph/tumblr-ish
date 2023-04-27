class CommentsController < ApplicationController
  def create
    @commentable = find_commentable
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
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

  def find_commentable
    if params[:comment][:commentable_type] == "Event"
      Event.find(params[:comment][:commentable_id])
    elsif params[:comment][:commentable_type] == "Article"
      Article.find(params[:comment][:commentable_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end
end
