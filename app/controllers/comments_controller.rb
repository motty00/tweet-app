class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to tweet_path(@comment.tweet)
    else
      @tweet = @comment.tweet
      @comments = @tweet.comments
      render "tweets/show"
    end
  end


  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
