class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :like_params, only: [:index, :show, :new]

  def index
    @tweets = Tweet.all.order('created_at desc')
    @users = User.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    if tweet.save
      redirect_to root_path
    else
      redirect_to new_tweet_path
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
    @like = Like.where(tweet_id: params[:id])
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to tweet_path
    else
      redirect_to edit_tweet_path
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to root_path
  end

  private
  def tweet_params
    params.require(:tweet).permit(:text).merge(user_id: current_user.id)
  end

  def like_params
    if user_signed_in? 
      @likes = Like.where(user_id: current_user.id).count
    end
  end



end
