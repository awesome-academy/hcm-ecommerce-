class ApplicationController < ActionController::Base
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :set_locale

  include SessionsHelper
  include CartsHelper
  include Pundit

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    return I18n.locale = locale if I18n.available_locales.include?(locale)

    I18n.locale = I18n.default_locale
  end

  def user_not_authorized exception
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit",
                                                           default: :default
    redirect_to(request.referer || root_path)
  end
end
