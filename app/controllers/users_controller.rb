class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def show
    @user = User.find(params[:id]) #特定のユーザー情報を取得
    @tweets = Tweet.all.order('created_at desc') # 全ての投稿を取得
    @likes = Like.where(user_id: current_user.id) if user_signed_in? # ログイン状態のユーザーであればお気に入りに登録したレコードを取得
  end
end
