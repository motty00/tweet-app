class RelationshipsController < ApplicationController
  before_action :set_user, only:[:create, :destroy]
  before_action :set_follow, only: [:index]


  def index
    users = Relationship.where(user_id: current_user.id)
    user = users.select(:follow_id)
    @users = User.where(id: user)
    @likes = Like.where(user_id: current_user.id) if user_signed_in? # ユーザーがログイン状態なら自分がお気に入りに追加した投稿を取得する
  end

  def create
    following = current_user.follow(@user)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to root_path
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_to root_path
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to root_path
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to root_path
    end
  end

  private
  def set_user
    @user = User.find(params[:follow_id])
  end

  def set_follow
    if user_signed_in?
      @follow = Relationship.where(user_id: current_user.id)
    end
  end


end
