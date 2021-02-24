class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @nickname = @user.nickname
    @introduction = @user.self_introduction
    @tweets = Tweet.all
  end

end
