class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
    @user = find_user_with_username
  end

  def new
    @user = User.new
  end

  def to_param
    username
  end

  def edit
    @user = find_user_with_username
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
    @user = find_user_with_username

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = find_user_with_username
    @user.destroy

    redirect_to users_path
  end

  private
    def user_params
      params.require(:user).permit(:username,
        :password,
	:password_confirmation,
	:email,
	:name,
	:age,
	:gender)
    end

    def find_user_with_username
      # really confusing, but params[:id] contains the username.
      User.where(username: params[:id]).first
    end

end
