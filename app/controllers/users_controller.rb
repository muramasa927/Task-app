class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :admin_user, only: [:index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :user_show, only: [:show]
  
  def show
    
  end
  
  def index
    @users = User.paginate(page: params[:page], per_page: 20) 
  end

  def new
    if logged_in? && !current_user.admin?
      flash[:info] = 'すでにログインしています。'
      redirect_to current_user
    end
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      log_in @user
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      #更新に成功した時の処理を記述
      flash[:success] = "ユーザー情報を更新しました"
      redirect_to @user
    else
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました"
    redirect_to users_url
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    # paramsハッシュからユーザーを取得します。
    def set_user
      @user = User.find(params[:id])
    end
    
    #beforeフィルター
    
    # アクセスしたユーザーが現在ログインしているユーザーか確認する
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to root_url unless current_user.admin?
    end
    
    # 管理者権限保有者か現在ログインしているユーザーかを確認する。詳細ページを開く際に使用する
    def user_show
      redirect_to root_url unless current_user.admin? || current_user?(@user)
    end
end

