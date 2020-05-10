class TasksController < ApplicationController
  before_action :set_task_user
  before_action :set_task, only: %i(show edit update destroy)
  before_action :logged_in_user
  before_action :correct_user
  
  def new
    @task = Task.new
  end
  
  def create
    @task = @user.tasks.build(task_params)
    if @task.save
      flash[:success] = "新規作成に成功しました"
      redirect_to user_tasks_url @user
    end
  end
  
  def show
  end
  
  def index
    @tasks = Task.where(user_id: @user.id)
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    @task.destroy
    flash[:success] = "タスクを削除しました"
    redirect_to user_tasks_url @user
  end
  
  private
  
    def task_params
      params.require(:task).permit(:task_name, :note)
    end
    
    def set_task_user
      @user = User.find(params[:user_id])
    end
    
    def set_task
      unless @task = @user.tasks.find_by(id: params[:id])
        flash[:danger] = "権限がありません。"
        redirect_to user_tasks_url @user
      end
    end
    
    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_url) unless current_user?(@user)
    end
  
    #ログイン済みのユーザーか確認する
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインして下さい"
        redirect_to login_url
      end
    end
end

