class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to prototype_path(@comment.prototype_id)
    else
      @prototype = Prototype.find(params[:prototype_id])
      comments = Comment.all
      @comments = comments.select do |x|
        x.prototype_id == @prototype.id
      end
      render "prototypes/show"
    end
  end

  private

  def comment_params
    params.permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end

end
