class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :like_params, only: [:show]
  before_action :tweet_params, except: [:show]

  def create
    Like.create(user_id: current_user.id, tweet_id: params[:id]) #ユーザーIDがログイン中のユーザー、投稿IDが選択した投稿IDのお気に入りを追加
    @likes = Like.where(user_id: current_user.id)
  end

  def destroy
    Like.find_by(user_id: current_user.id, tweet_id: params[:id]).destroy #ユーザーIDがログイン中のユーザー、投稿IDが選択した投稿IDのお気に入りを削除
    @likes = Like.where(user_id: current_user.id)
  end

  def index
    @likes = Like.where(user_id: current_user.id) #likesテーブルからuser_idがログインユーザーIDのデータを取得
  end

  def show
    likes = Like.where(user_id: current_user.id) #likesテーブルからuser_idがログインユーザーのレコードを取得
    like = likes.select(:tweet_id) #取得したレコードのtweet_idを取得（変数likeにはtweet_idの数値が入る）
    @tweets = Tweet.where(id: like) #tweetsテーブルからidが変数likeに入っているレコードを取得
  end




  def like_params
    if user_signed_in? 
      @likes = Like.where(user_id: current_user.id) #ログイン状態ならlikesテーブルから自分のユーザーIDのレコードを取得
    end
  end

  def tweet_params
    @tweet = Tweet.find(params[:id])
  end

end
