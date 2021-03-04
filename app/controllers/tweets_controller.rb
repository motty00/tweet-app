class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_find, only: [:show, :edit]
  before_action :set_like, only: [:index, :show, :new, :edit]
  before_action :move_to_index, except: [:index, :show, :edit, :update, :create, :destroy]

  def index
    @tweets = Tweet.all.order('created_at desc') # 全ての投稿を新しい順に表示
    @users = User.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweets = Tweet.all.order('created_at desc')
    Tweet.create(tweet_params)
  end

  def show
    @like = Like.where(tweet_id: params[:id]) # 特定の投稿IDのお気に入りの数を取得
    @comment = Comment.new
    @comments = @tweet.comments.order('created_at desc')
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweets_params)
      redirect_to tweet_path # 更新に成功したら投稿詳細ページに遷移
    else
      redirect_to edit_tweet_path # 更新に失敗したら投稿編集ページに戻る
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to root_path # 削除が完了したらトップページに遷移
  end

  private

  def tweet_params
    params.permit(:text).merge(user_id: current_user.id)
  end

  def tweets_params
    params.require(:tweet).permit(:text).merge(user_id: current_user.id)
  end

  def set_find
    @tweet = Tweet.find(params[:id]) # 特定の投稿IDを取得
  end

  def set_like
    @likes = Like.where(user_id: current_user.id) if user_signed_in? # ユーザーがログイン状態なら自分がお気に入りに追加した投稿を取得する
  end

  def move_to_index
    if user_signed_in?
      redirect_to action: :index
    end
  end

end
