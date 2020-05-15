class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  #ログイン済みのユーザーか確認する
  def logged_in_user
    unless logged_in?
      flash[:danger] = "ログインして下さい"
      redirect_to login_url
    end
  end
  
end
