class CommentsController < ApplicationController
  def create
    @comments = Comment.new(comment_params)
    if @comments.save
      redirect_to tweet_path(@comments.tweet)
    else
      redirect_to tweet_path(@comments.tweet)
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user_id: current_user.id, tweet_id: params[:tweet_id])
  end
end
