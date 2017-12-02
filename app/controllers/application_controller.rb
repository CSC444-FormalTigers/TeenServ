class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :banned?
  # before_action :set_locale#tempLocaleTag

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys:
      [:username,
       :email,
       :paypal_email,
       :password,
       :password_confirmation,
       :name,
	   :account_type,
	   :terms_of_service])
  end

  def redirect_if_not_admin
    if !(current_user.admin?)
      redirect_to root_path
    end
  end

  def redirect_if_not_employer
    if !(current_user.account_type == "employer")
      redirect_to root_path
    end
  end

    rescue_from ActiveRecord::RecordNotFound do
    flash[:warning] = 'Resource not found.'
    redirect_back_or root_path
  end

  def redirect_back_or(path)
    redirect_to request.referer || path
  end

  def banned?
    if current_user.present? && current_user.banned?
      sign_out current_user
      flash[:error] = "This account has been banned"
      redirect_to root_path
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  # def default_url_options
  #   { locale: I18n.locale }
  # end#tempLocaleTag
end