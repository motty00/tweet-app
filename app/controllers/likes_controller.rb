class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :like_params, only: [:show]

  def create
    Like.create(user_id: current_user.id, tweet_id: params[:id])
    redirect_to root_path
  end

  def destroy
    Like.find_by(user_id: current_user.id, tweet_id: params[:id]).destroy
    redirect_to root_path
  end

  def index
    @likes = Like.find_by(user_id: current_user.id)
  end

  def show
    likes = Like.where(user_id: current_user.id)
    like = likes.select(:tweet_id)
    @tweets = Tweet.where(id: like)
  end




  def like_params
    if user_signed_in? 
      @likes = Like.where(user_id: current_user.id).count
    end
  end

end
