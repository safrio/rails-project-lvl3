# frozen_string_literal: true

module AuthConcern
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.delete(:user_id)
    session.clear
  end

  def signed_in?
    !!current_user&.present?
  end

  def admin?
    !!current_user&.admin?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate_user!
    return if signed_in?

    redirect_to root_path, alert: t('restricted_content')
  end

  def authenticate_admin!
    return redirect_to root_path, alert: t('restricted_content') unless current_user.admin?
  end
end
