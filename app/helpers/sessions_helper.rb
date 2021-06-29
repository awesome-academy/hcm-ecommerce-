module SessionsHelper
  def loggin_user user
    session[:user_id] = user.id
  end

  def current_user
    if (user_id = session[:user_id])
      @user ||= User.find_by(id: user_id)
    elsif (user_id = cookies[:user_id])
      user = User.find_by(id: user_id)
      return unless user

      if user.authenticate?(:remember, cookies[:remember_token])
        loggin_user user
        @user = user
      end
    end
  end

  def loggin?
    current_user.present?
  end

  def logout_user
    forgot_user current_user
    session.delete(:user_id)
    @user = nil
    redirect_to root_path
  end

  def remember_user user
    user.remember
    cookies.signed[:remember_token] = user.remember_token
    cookies.permanent.signed[:user_id] = user.id
  end

  def forgot_user user
    user.forgot
    cookies.delete(:remember_token)
    cookies.delete(:user_id)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
