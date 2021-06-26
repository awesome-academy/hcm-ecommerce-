class SessionsController < ApplicationController
  def new; end

  def create
    sessions = params[:session]
    is_validate = validate_login sessions
    @user = User.find_by(email: sessions[:email].downcase)
    if is_validate && @user&.authenticate?(:password, sessions[:password])
      login
      redirect_to session[:forwarding_url] || root_path
    else
      flash.now[:error] = message_error is_validate
      render :new
    end
  end

  def destroy
    logout_user if loggin?
  end

  private

  def login
    loggin_user(@user)
    session[:remember] == "1" ? remember_user(@user) : forgot_user(@user)
    flash[:success] = t "common.flash.login_success"
  end

  def message_error value
    t("common.flash.#{value ? 'login_invalid' : 'login_required'}")
  end

  def validate_login session
    return false if session[:email].blank? || session[:password].blank?

    true
  end
end
