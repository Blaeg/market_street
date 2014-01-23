class CommentsController < ApplicationController
  before_filter :require_user

  def create
    commentable_class = allowed_params[:commentable_type].constantize
    commentable = commentable_class.find(allowed_params[:commentable_id])
    comment = commentable.comments.build(allowed_params)
    comment.created_by = comment.user_id = current_user.id
    if comment.save
      render :json => { comment: comment }
    else
      render :json => comment.errors, :status => 406 #not acceptable
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    if comment.user.id == current_user.id and comment.destroy
      render json: {}, status: 200
    else
      render json: comment.errors, status: 401 #not authorized
    end
  end  

  private

  def allowed_params
    params.require(:comment).permit(:note, :commentable_id, 
      :commentable_type)
  end
end