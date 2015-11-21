class CommentsController < ApplicationController
  def create
    @pin = Pin.find(comment_params[:pin_id])
    @user = current_user
    @comment = @user.comments.new(comment_params)
    @comment.save
    @comments = Comment.where(pin_id: @pin.id)
    render 'pins/show'
  end
  
  private
    def comment_params
      params.require(:comment).permit(:pin_id, :comment_text)
    end
end
