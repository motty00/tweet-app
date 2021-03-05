class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like, only: [:show]
  before_action :set_tweet, except: [:show]
  before_action :like_where, only: [:create, :destroy, :index, :show]

  def create
    Like.create(user_id: current_user.id, tweet_id: params[:id]) # ユーザーIDがログイン中のユーザー、投稿IDが選択した投稿IDのお気に入りを追加
  end

  def destroy
    Like.find_by(user_id: current_user.id, tweet_id: params[:id]).destroy # ユーザーIDがログイン中のユーザー、投稿IDが選択した投稿IDのお気に入りを削除
  end

  def index
  end

  def show
    like = @likes.select(:tweet_id) # 取得したレコードのtweet_idを取得（変数likeにはtweet_idの数値が入る）
    @tweets = Tweet.where(id: like) # tweetsテーブルからidが変数likeに入っているレコードを取得
  end


  private

  def set_like
    if user_signed_in?
      @likes = Like.where(user_id: current_user.id) # ログイン状態ならlikesテーブルから自分のユーザーIDのレコードを取得
    end
  end

  def like_where
    @likes = Like.where(user_id: current_user.id) # likesテーブルからuser_idがログインユーザーIDのデータを取得
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
