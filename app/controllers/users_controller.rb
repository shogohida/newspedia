class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    @user.save
    # Cloudinery
  end

  private

  def user_params
    params.require(:user).permit(:name, :photo)
  end
end

# test memo
