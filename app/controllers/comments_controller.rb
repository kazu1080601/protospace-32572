class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype_id)
    else
      render "prototypes/show"
    end
  end

  private

  def comment_params
    params.permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

end