class UsersController < ApplicationController
  before_action :redirect_if_not_this_user_or_admin, only: [:edit,
    :update,
    :destroy]
  before_action :redirect_if_not_admin, only: [
    :grant_admin,
    :remove_admin
  ]

  def index
    # attributes_to_display should contain names of the columns in
    # the Users model.
    @attributes_to_display = ['username',
      'email',
      'account_type']

    @user = User.all
  end

  def show
    @user = find_user_with_username
  end

  def to_param
    username
  end

  def edit
    @user = find_user_with_username
  end

  def update
    @user = find_user_with_username

    if @user.update(user_params)
      bypass_sign_in @user
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

  def grant_admin
    @user = find_user_with_username
    @user.update_attribute :admin, true

    redirect_to @user
  end

  def remove_admin
    @user = find_user_with_username
    @user.update_attribute :admin, false

    redirect_to @user
  end

  private
    def user_params
      params.require(:user).permit(:username,
        :password,
	:password_confirmation,
	:email,
	:name,
	:age,
	:gender,
	:cell_phone,
	:home_phone,
	:address,
	:photo,
	:account_type)
    end

    def find_user_with_username
      # really confusing, but params[:id] contains the username.
      User.where(username: params[:id]).first
    end

    def redirect_if_not_this_user_or_admin
      @user = find_user_with_username
      if !(@user == current_user) and !(current_user.admin)
        redirect_to root_path
      end
    end
end
