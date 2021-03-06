class TweetsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_tweet, only: [:index, :create]
  before_action :find_tweet, only: [:update, :destroy]
  before_action :set_find, only: [:show, :edit]
  before_action :set_like, only: [:index, :show, :new, :edit]
  before_action :move_to_index, except: [:index, :show, :edit, :update, :create, :destroy]
  before_action :move_index, only: [:edit]

  def index
    @users = User.all # 全てのユーザー情報を取得
  end

  def new
    @tweet = Tweet.new
  end

  def create
    Tweet.create(tweet_params)
  end

  def show
    @like = Like.where(tweet_id: params[:id]) # 特定の投稿IDのお気に入りの数を取得
    @comment = Comment.new
    @comments = @tweet.comments.order('created_at desc') # 特定の投稿に対するコメントを取得
    @commentall = Comment.all # コメントを全て取得
  end

  def edit
  end

  def update
    if @tweet.update(tweets_params)
      redirect_to tweet_path # 更新に成功したら投稿詳細ページに遷移
    else
      redirect_to edit_tweet_path # 更新に失敗したら投稿編集ページに戻る
    end
  end

  def destroy
    @tweet.destroy
  end

  private

  def tweet_params
    params.permit(:text).merge(user_id: current_user.id)
  end

  def tweets_params
    params.require(:tweet).permit(:text).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweets = Tweet.all.order('created_at desc') # 全てのツイート情報を取得
  end

  def find_tweet
    @tweet = Tweet.find(params[:id]) # 特定のツイート情報を取得
  end

  def set_find
    @tweet = Tweet.find(params[:id]) # 特定の投稿IDを取得
  end

  def set_like
    @likes = Like.where(user_id: current_user.id) if user_signed_in? # ユーザーがログイン状態なら自分がお気に入りに追加した投稿を取得する
  end

  def move_to_index
    redirect_to action: :index if user_signed_in?
  end

  def move_index
    tweet = Tweet.find(params[:id])
    if current_user.id != tweet.user_id
      redirect_to root_path
    end
  end

end
