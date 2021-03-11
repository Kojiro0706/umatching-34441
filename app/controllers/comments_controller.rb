class CommentsController < ApplicationController
  def create
    @builder = Builder..find(params[:builder_id])
    @comment = Comment.new(comment_params)
    if comment.save
      redirect_to "/builders/#{@comment.builder.id}"
    else
      @builders = @comment.builder
      @comments = @builder.comments
      render "builders/show"
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end
