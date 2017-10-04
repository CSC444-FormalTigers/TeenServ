class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
    @user = User.where(username: params[:id]).first
  end

  def new
    @user = User.new
  end

  def to_param
    username
  end

  def edit
    @user = User.where(username: params[:id]).first
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.where(username: params[:id]).first

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.where(username: params[:id]).first
    @user.destroy

    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :email)
    end
end
