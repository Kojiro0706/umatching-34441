class CommentsController < ApplicationController
  def create
    @builder = Builder.find(params[:builder_id])
    @comment = Comment.new(comment_params)
    @user = User.find_by(id: current_user.id)
    if @comment.save
      ActionCable.server.broadcast 'comment_channel', content: @comment, user: @user
    else
      @builders = @comment.builder
      @comments = @builder.comments
      render 'builders/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, builder_id: params[:builder_id])
  end
end
