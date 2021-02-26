class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @introduction = @user.self_introduction
    @tweets = Tweet.all
    if user_signed_in? 
      @likes = Like.where(user_id: current_user.id).count
    end
  end

end
