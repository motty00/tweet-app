class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :move_index, only: [:edit]

  def show
    @user = User.find(params[:id]) # 特定のユーザー情報を取得
    @tweets = Tweet.all.order('created_at desc') # 全ての投稿を取得
    @likes = Like.where(user_id: current_user.id) if user_signed_in? # ログイン状態のユーザーであればお気に入りに登録したレコードを取得
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      redirect_to user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :self_introduction)
  end

  def move_index
    user = User.find(params[:id])
    redirect_to root_path if current_user.id != user.id
  end
end
