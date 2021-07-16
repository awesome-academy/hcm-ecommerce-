class SessionsController < ApplicationController
  before_action :check_admin?, except: [:destroy]

  def new; end

  def create
    sessions = params[:session]
    @user = User.find_by(email: sessions[:email].downcase)
    if @user&.authenticate?(:password, sessions[:password])
      login
      redirect_to admin_root_path && return if is_admin?
    else
      flash.now[:error] = t "common.flash.login_invalid"
      render :new
    end
  end

  def destroy
    logout_user if loggin?
  end

  private

  def login
    loggin_user(@user)
    remember = params[:session][:remember]
    remember == "1" ? remember_user(@user) : forgot_user(@user)
    flash[:success] = t "common.flash.login_success"
    redirect_to session[:forwarding_url] || root_path
    session[:forwarding_url] = ""
  end
end
