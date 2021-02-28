class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  
  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @introduction = @user.self_introduction
    @tweets = Tweet.all #全ての投稿を取得
    if user_signed_in? #ログイン状態のユーザーであればお気に入りに登録したレコードを取得
      @likes = Like.where(user_id: current_user.id)
    end
  end

end
