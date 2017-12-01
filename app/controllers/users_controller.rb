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

        #Sort users hash by username
	@user = User.all.sort_by { |user| user["username"] }
  end

  def show
    # attributes_to_display should contain names of the columns in
    # the Users model.
    @attributes_to_display = ['username',
      'email',
	  'age',
	  'gender',
	  'cell_phone',
	  'home_phone',
	  'name',
	  'address',
      'account_type']
    @user = find_user_with_id
  end

  def edit
    @user = find_user_with_id
  end

  def update
    @user = find_user_with_id
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    if @user.update(user_params)
      bypass_sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = find_user_with_id
    @user.destroy

    redirect_to users_path
  end

  def grant_admin
    @user = find_user_with_id
    @user.update_attribute :admin, true

    redirect_to @user
  end

  def remove_admin
    @user = find_user_with_id
    @user.update_attribute :admin, false

    redirect_to @user
  end

  def resume
    @user = find_user_with_id
    if @user.resume.file.nil?
      redirect_to @user
    elsif Rails.env.production?
      pdf = open(@user.resume.url)
      send_data pdf.read, filename: "#{@user.resume.file.filename}", type: "application/pdf", disposition: 'inline'
    else
      send_file @user.resume.current_path, filename: "#{@user.resume.file.identifier}", type: "application/pdf", disposition: 'inline'
    end
  end

  def upvote
    @user = find_user_with_id
    User.increment_counter(:rating, params[:id])
    redirect_to @user
  end

  def downvote
    @user = find_user_with_id
    User.decrement_counter(:rating, params[:id])
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
        :avatar,
        :resume,
        :paypal_email)
    end

    def find_user_with_id
      # really confusing, but params[:id] contains the username.
      User.where(id: params[:id]).first
    end

    def redirect_if_not_this_user_or_admin
      @user = find_user_with_id
      if !(@user == current_user) and !(current_user.admin)
        redirect_to root_path
      end
    end
end
