class CommentsController < ApplicationController
  def create
    @pin = Pin.find(comment_params[:pin_id])
    @user = current_user
    @comment = @user.comments.new(comment_params)
    if @comment.save
      
    else
      
    end
    redirect_to @pin
  end
  
  private
    def comment_params
      params.require(:comments).permit(:pin_id, :comment_text)
    end
end
