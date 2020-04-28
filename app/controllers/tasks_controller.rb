class TasksController < ApplicationController
  before_action :set_task_user, only: :index
  
  def new
  end
  
  def show
    @task = params[:id]
  end
  
  def index
    @tasks = Task.where(user_id: @user.id)
  end
  
  def set_task_user
    @user = User.find(params[:user_id])
  end
end

